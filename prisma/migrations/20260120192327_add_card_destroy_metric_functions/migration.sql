-- Card destroy metric functions
-- get_card_destroy_count: destroyed count per card (all matches)
CREATE OR REPLACE FUNCTION get_card_destroy_count(
  p_player_id text DEFAULT NULL,
  p_player_card_id text DEFAULT NULL
)
RETURNS TABLE (
  destroyed_player_card_id text,
  destroyed_count int
)
LANGUAGE sql
AS $$
  SELECT
    cde.destroyed_player_card_id,
    COUNT(*)::int AS destroyed_count
  FROM card_destroy_events cde
  LEFT JOIN player_cards pc ON pc.id = cde.destroyed_player_card_id
  WHERE (p_player_card_id IS NULL OR cde.destroyed_player_card_id = p_player_card_id)
    AND (p_player_id IS NULL OR pc."playerId" = p_player_id)
  GROUP BY cde.destroyed_player_card_id
  ORDER BY destroyed_count DESC;
$$;

-- get_card_destroy_round_distribution: destroyed round distribution per card (all matches)
CREATE OR REPLACE FUNCTION get_card_destroy_round_distribution(
  p_player_id text DEFAULT NULL,
  p_player_card_id text DEFAULT NULL
)
RETURNS TABLE (
  round_number int,
  destroyed_player_card_id text,
  destroyed_count int
)
LANGUAGE sql
AS $$
  SELECT
    cde.round_number,
    cde.destroyed_player_card_id,
    COUNT(*)::int AS destroyed_count
  FROM card_destroy_events cde
  LEFT JOIN player_cards pc ON pc.id = cde.destroyed_player_card_id
  WHERE (p_player_card_id IS NULL OR cde.destroyed_player_card_id = p_player_card_id)
    AND (p_player_id IS NULL OR pc."playerId" = p_player_id)
  GROUP BY cde.round_number, cde.destroyed_player_card_id
  ORDER BY cde.round_number, destroyed_count DESC;
$$;
