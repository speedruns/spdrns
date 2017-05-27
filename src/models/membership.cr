class Membership < Crecto::Model
  # Roles the User can play
  enum Role
    PARTICIPANT  # the user is part of the event (read + write)
    OBSERVER     # the user is watching the event (read only)
  end

  # States the User can be in
  enum State
    REGISTERED # the user has promised to be present
    JOINED     # the user is present, but is not fully prepared
    READY      # the user is fully prepared to start
    DONE       # the user successfully finished
    FAILED     # the user failed to properly finish
    FORFEITED  # the user voluntarily left the race
    DESERTED   # the user abruptly left the race (e.g., rage-quit)
  end

  schema "memberships" do
    field :time,  Time
    enum_field :role,  Role
    enum_field :state, State

    belongs_to :user, User
    belongs_to :race, Race
  end

  def initialize(user : User, race : Race, role=Role::OBSERVER, state=State::REGISTERED)
    self.user   = user
    self.race   = race
    self.role   = role
    self.state  = state
  end
  def self.participant(user, race); new(user, race, Role::PARTICIPANT); end
  def self.observer(user, race);    new(user, race, Role::OBSERVER);    end


  ### Roles
  def to_participant; to(Role::PARTICIPANT);  end
  def to_observer;    to(Role::OBSERVER);     end

  def to(role : Role)
    self.role = role
    self
  end


  ### State Transitions
  ACTIONS = [
    # Reversable actions
    :join,  :unjoin,
    :ready, :unready,
    :done,  :undone,
    # Non-reversable actions
    :fail,
    :forfeit,
    :desert
  ]

  def join;     transition(to: State::JOINED);      end
  def unjoin;   transition(to: State::REGISTERED);  end
  def ready;    transition(to: State::READY);       end
  def unread;   transition(to: State::JOINED);      end
  def done
    transition(to: State::DONE)
    self.time = Time.new(race.elapsed_time.ticks)
    self
  end
  def undone;   transition(to: State::READY);       end
  def fail;     transition(to: State::FAIELD);      end
  def forfeit;  transition(to: State::FORFEITED);   end
  def desert;   transition(to: State::DESERTED);    end

  def transition(to new_state : State, from old_states = nil)
    valid_transition = case old_states
    when String
      self.state == old_states
    when Array(String)
      old_states.includes?(self.state)
    else
      true
    end

    self.state = new_state if valid_transition
    self
  end

  def ready?; self.state == State::READY; end
  def done?;  self.state == State::DONE;  end
end
