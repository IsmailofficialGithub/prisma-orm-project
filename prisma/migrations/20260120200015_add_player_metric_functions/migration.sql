-- Player metrics functions
-- get_daily_active_players: daily active/new/returning players for a date range
CREATE OR REPLACE FUNCTION get_daily_active_players(
  p_from timestamptz,
  p_to timestamptz
)
RETURNS TABLE (
  day timestamptz,
  daily_active_players bigint,
  new_players bigint,
  returning_players bigint
)
LANGUAGE sql
AS $$
  SELECT
    date_trunc('day', ps.session_started_at) AS day,
    COUNT(DISTINCT ps.player_id) AS daily_active_players,
    COUNT(DISTINCT CASE
      WHEN date_trunc('day', p."createdAt") = date_trunc('day', ps.session_started_at)
      THEN ps.player_id
    END) AS new_players,
    COUNT(DISTINCT CASE
      WHEN date_trunc('day', p."createdAt") <> date_trunc('day', ps.session_started_at)
      THEN ps.player_id
    END) AS returning_players
  FROM player_sessions ps
  JOIN players p ON p.id = ps.player_id
  WHERE ps.session_started_at IS NOT NULL
    AND ps.player_id IS NOT NULL
    AND ps.session_started_at >= p_from
    AND ps.session_started_at < p_to
  GROUP BY day
  ORDER BY day;
$$;

-- get_player_login_events: login events list for a date range
CREATE OR REPLACE FUNCTION get_player_login_events(
  p_from timestamptz,
  p_to timestamptz,
  p_player_id text DEFAULT NULL,
  p_limit int DEFAULT 100,
  p_offset int DEFAULT 0
)
RETURNS TABLE (
  id text,
  player_id text,
  session_started_at timestamptz
)
LANGUAGE sql
AS $$
  SELECT
    ps.id,
    ps.player_id,
    ps.session_started_at
  FROM player_sessions ps
  WHERE ps.session_started_at IS NOT NULL
    AND ps.player_id IS NOT NULL
    AND ps.session_started_at >= p_from
    AND ps.session_started_at < p_to
    AND (p_player_id IS NULL OR ps.player_id = p_player_id)
  ORDER BY ps.session_started_at DESC
  LIMIT p_limit
  OFFSET p_offset;
$$;

-- get_player_sessions: session list for a date range
CREATE OR REPLACE FUNCTION get_player_sessions(
  p_from timestamptz,
  p_to timestamptz,
  p_player_id text DEFAULT NULL,
  p_limit int DEFAULT 100,
  p_offset int DEFAULT 0
)
RETURNS TABLE (
  id text,
  player_id text,
  session_started_at timestamptz,
  session_ended_at timestamptz
)
LANGUAGE sql
AS $$
  SELECT
    ps.id,
    ps.player_id,
    ps.session_started_at,
    ps.session_ended_at
  FROM player_sessions ps
  WHERE ps.session_started_at IS NOT NULL
    AND ps.player_id IS NOT NULL
    AND ps.session_started_at >= p_from
    AND ps.session_started_at < p_to
    AND (p_player_id IS NULL OR ps.player_id = p_player_id)
  ORDER BY ps.session_started_at DESC
  LIMIT p_limit
  OFFSET p_offset;
$$;

-- get_player_match_counts: match counts per player in a date range
CREATE OR REPLACE FUNCTION get_player_match_counts(
  p_from timestamptz,
  p_to timestamptz,
  p_player_id text DEFAULT NULL
)
RETURNS TABLE (
  "playerId" text,
  "matchesStarted" int,
  "matchesCompleted" int
)
LANGUAGE sql
AS $$
  SELECT
    mpd."playerId" AS "playerId",
    COUNT(*)::int AS "matchesStarted",
    COUNT(*) FILTER (WHERE m.status = 'completed')::int AS "matchesCompleted"
  FROM match_player_decks mpd
  JOIN matches m ON m.id = mpd."matchId"
  WHERE mpd."playerId" IS NOT NULL
    AND m."createdAt" >= p_from
    AND m."createdAt" < p_to
    AND (p_player_id IS NULL OR mpd."playerId" = p_player_id)
  GROUP BY mpd."playerId"
  ORDER BY mpd."playerId";
$$;
