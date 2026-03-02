-- Card damage metric functions
-- get_card_damage_total: total damage by card (per match / all matches)
CREATE OR REPLACE FUNCTION get_card_damage_total(
  p_match_id text DEFAULT NULL,
  p_player_id text DEFAULT NULL,
  p_player_card_id text DEFAULT NULL
)
RETURNS TABLE (
  attacker_player_card_id text,
  total_damage int
)
LANGUAGE sql
AS $$
  SELECT
    cde.attacker_player_card_id,
    SUM(cde.damage_amount)::int AS total_damage
  FROM card_damage_events cde
  LEFT JOIN player_cards pc ON pc.id = cde.attacker_player_card_id
  WHERE (p_match_id IS NULL OR cde.match_id = p_match_id)
    AND (p_player_card_id IS NULL OR cde.attacker_player_card_id = p_player_card_id)
    AND (p_player_id IS NULL OR pc."playerId" = p_player_id)
  GROUP BY cde.attacker_player_card_id
  ORDER BY total_damage DESC;
$$;

-- get_card_damage_average: average damage by card (per match / all matches)
CREATE OR REPLACE FUNCTION get_card_damage_average(
  p_match_id text DEFAULT NULL,
  p_player_id text DEFAULT NULL,
  p_player_card_id text DEFAULT NULL
)
RETURNS TABLE (
  attacker_player_card_id text,
  average_damage float
)
LANGUAGE sql
AS $$
  SELECT
    cde.attacker_player_card_id,
    AVG(cde.damage_amount)::float AS average_damage
  FROM card_damage_events cde
  LEFT JOIN player_cards pc ON pc.id = cde.attacker_player_card_id
  WHERE (p_match_id IS NULL OR cde.match_id = p_match_id)
    AND (p_player_card_id IS NULL OR cde.attacker_player_card_id = p_player_card_id)
    AND (p_player_id IS NULL OR pc."playerId" = p_player_id)
  GROUP BY cde.attacker_player_card_id
  ORDER BY average_damage DESC;
$$;

-- get_card_damage_round_total: total damage per card per round (per match / all matches)
CREATE OR REPLACE FUNCTION get_card_damage_round_total(
  p_match_id text DEFAULT NULL,
  p_player_id text DEFAULT NULL,
  p_player_card_id text DEFAULT NULL
)
RETURNS TABLE (
  round_number int,
  attacker_player_card_id text,
  total_damage int
)
LANGUAGE sql
AS $$
  SELECT
    crde.round_number,
    crde.attacker_player_card_id,
    SUM(crde.damage_amount)::int AS total_damage
  FROM card_round_damage_events crde
  LEFT JOIN player_cards pc ON pc.id = crde.attacker_player_card_id
  WHERE (p_match_id IS NULL OR crde.match_id = p_match_id)
    AND (p_player_card_id IS NULL OR crde.attacker_player_card_id = p_player_card_id)
    AND (p_player_id IS NULL OR pc."playerId" = p_player_id)
  GROUP BY crde.round_number, crde.attacker_player_card_id
  ORDER BY crde.round_number, total_damage DESC;
$$;
