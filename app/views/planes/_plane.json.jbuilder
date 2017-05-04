json.extract! plane, :id, :name
json.state plane.aasm_state
json.human_state plane.aasm.human_state
json.history_state plane.history_human_states