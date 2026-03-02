-- CreateTable

-- this is not in use right now 
CREATE TABLE "nft_metadata" (
    "id" BIGSERIAL NOT NULL,
    "player_cards" BIGINT NOT NULL,
    "token_id" TEXT NOT NULL,
    "video_url" TEXT,
    "image_url" TEXT,
    "animation_url" TEXT,
    "traits" JSONB NOT NULL DEFAULT '[]',
    "items" JSONB,
    "total_damage_taken" INTEGER NOT NULL DEFAULT 0,
    "total_damage_done" INTEGER NOT NULL DEFAULT 0,
    "total_wins" INTEGER NOT NULL DEFAULT 0,
    "games_played" INTEGER NOT NULL DEFAULT 0,
    "total_heals_cast" INTEGER NOT NULL DEFAULT 0,
    "cards_destroyed" INTEGER NOT NULL DEFAULT 0,
    "deaths" INTEGER NOT NULL DEFAULT 0,
    "last_match_at" TIMESTAMPTZ(6),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "nft_metadata_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "nft_metadata_player_cards_key" ON "nft_metadata"("player_cards");

-- CreateIndex
CREATE UNIQUE INDEX "nft_metadata_token_id_key" ON "nft_metadata"("token_id");
