-- AlterTable
ALTER TABLE "public"."player_cards" 
ADD COLUMN     "cards_destroyed" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "deaths" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "games_played" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "is_archived" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "last_match_at" TIMESTAMPTZ(6),
ADD COLUMN     "total_heals_cast" INTEGER NOT NULL DEFAULT 0;
