class User < Crecto::Model
  schema "users" do
    field :name,  String
    has_many :memberships, Membership, dependent: :destroy
    has_many :races, Race, through: :memberships
  end

  validate_required [:name]

  def initialize(name : String)
    self.name = name
  end

  ### Membership
  def register(race : Race)
    race.add_participant(self)
  end

  def observe(race : Race)
    race.add_observer(self)
  end

  def leave(race : Race)
    race.remove_user(self)
  end


  ### State
  {% for action in Membership::ACTIONS %}
    def {{ action.id }}(race : Race)
      membership = Repo.get_by(Membership, user_id: self.id.as(DbValue), race_id: race.id)
      if membership
        membership.{{ action.id }}(race)
        Repo.update(membership)
      end
    end
  {% end %}
end

