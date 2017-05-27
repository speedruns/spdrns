class Race < Crecto::Model
  enum State
    CREATED    # created, but not ready for registrations
    OPEN       # accepting registrations
    CLOSED     # no longer accepting registrations
    STARTED    # running and proceeding
    PAUSED     # running but not proceeding
    FINISHED   # done successfully
    CANCELED   # done, but not finished
  end

  schema "races" do
    field :name,        String
    field :start_time,  Time
    field :end_time,    Time
    enum_field :state,  State

    has_many :memberships, Membership, dependent: :destroy
    has_many :users, User, through: :memberships
  end

  # def initialize(@state=State::CREATED); end


  macro ensure_state(state, ret_value=false)
    return {{ ret_value }} unless self.state == {{ state }}
  end

  def valid_actions
    case self.state
    when State::CREATED
      [:open, :cancel]
    when State::OPEN
      [:close]
    when State::CLOSED
      [:start, :cancel]
    when State::STARTED
      [:pause, :finish, :cancel]
    when State::PAUSED
      [:start, :cancel]
    when State::FINISHED
      [] of String
    when State::CANCELED
      [] of String
    else
      [] of String
    end
  end


  ### PARTICIPATION

  # Return only the Memberships that are Participants in the Race
  def participants : Array(Membership)
    memberships.select{ |m| m.role == Membership::Role::PARTICIPANT }
  end

  # Return only the Memberships that are Observers of the Race
  def observers : Array(Membership)
    memberships.select{ |m| m.role == Membership::Role::OBSERVER }
  end


  ### EXECUTION

  def open; self.state = State::OPEN; end
  def close; self.state = State::CLOSED; end

  def start
    m = self.participants
    return false unless m && m.all?(&.ready?)
    self.start_time = Time.now
    self.state = State::STARTED
  end

  def pause; self.state = State::PAUSED; end

  def finish
    self.end_time = Time.now
    self.state = State::FINISHED
  end

  def cancel; self.state = State::CANCELED; end

  def elapsed_time : Time::Span
    case start = self.start_time
    when Time
      (self.end_time || Time.now) - start
    else
      Time::Span.new(0)
    end
  end
end
