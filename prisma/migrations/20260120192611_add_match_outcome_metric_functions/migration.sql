-- Match outcome metric function
-- get_match_outcome_by_match_id: outcome rows for a match (per player)
CREATE OR REPLACE FUNCTION get_match_outcome_by_match_id(
  p_match_id text
)
RETURNS TABLE (
  player_id text,
  match_outcome text,
  finishing_round int
)
LANGUAGE sql
AS $$
  SELECT
    moe.player_id,
    moe.match_outcome,
    moe.finishing_round
  FROM match_outcome_events moe
  WHERE moe.match_id = p_match_id
  ORDER BY moe.player_id;
$$;
