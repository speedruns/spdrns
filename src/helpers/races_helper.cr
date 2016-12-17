macro race_state_label(state)
  %(<span class="race-state">#{{{state}}}</span>)
end

def colored_icon_for_member_state(member_state)
  case member_state
  when Membership::State::Ready
    %(<i class="fa fa-check ready"></i>)
  when Membership::State::Ready
  else
    "Nope"
  end
end
