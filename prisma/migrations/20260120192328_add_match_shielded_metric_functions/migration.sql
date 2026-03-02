-- Match shielded hit metric function
-- get_match_shielded_hit_stats: shielded hit stats (per match / per card)
CREATE OR REPLACE FUNCTION get_match_shielded_hit_stats(
  p_match_id text DEFAULT NULL,
  p_player_card_id text DEFAULT NULL
)
RETURNS TABLE (
  target_hero_id int,
  target_player_card_id text,
  attacker_player_card_id text,
  hit_count int,
  total_damage_taken_amount int,
  total_damage_shield_absorbed int
)
LANGUAGE sql
AS $$
  SELECT
    mhe.target_hero_id,
    mhe.target_player_card_id,
    mhe.attacker_player_card_id,
    COUNT(*)::int AS hit_count,
    SUM(mhe.damage_taken_amount)::int AS total_damage_taken_amount,
    SUM(COALESCE(mhe.shield_absorbed, 0))::int AS total_damage_shield_absorbed
  FROM match_shielded_hit_events mhe
  WHERE (p_match_id IS NULL OR mhe.match_id = p_match_id)
    AND (
      p_player_card_id IS NULL
      OR mhe.target_player_card_id = p_player_card_id
      OR mhe.attacker_player_card_id = p_player_card_id
    )
  GROUP BY
    mhe.target_hero_id,
    mhe.target_player_card_id,
    mhe.attacker_player_card_id
  ORDER BY hit_count DESC;
$$;
