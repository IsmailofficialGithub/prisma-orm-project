-- CreateEnum
CREATE TYPE "public"."MatchOutcome" AS ENUM ('WIN', 'LOSS', 'DRAW');

-- CreateTable
CREATE TABLE "public"."card_damage_events" (
    "id" VARCHAR(36) NOT NULL,
    "match_id" VARCHAR(36) NOT NULL,
    "match_round_id" VARCHAR(36),
    "attacker_player_card_id" VARCHAR(36) NOT NULL,
    "target_player_card_id" VARCHAR(36),
    "target_hero_id" INTEGER,
    "damage_amount" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "card_damage_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."card_round_damage_events" (
    "id" VARCHAR(36) NOT NULL,
    "match_id" VARCHAR(36) NOT NULL,
    "match_round_id" VARCHAR(36),
    "round_number" INTEGER NOT NULL,
    "attacker_player_card_id" VARCHAR(36) NOT NULL,
    "damage_amount" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "card_round_damage_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."card_destroy_events" (
    "id" VARCHAR(36) NOT NULL,
    "match_id" VARCHAR(36) NOT NULL,
    "match_round_id" VARCHAR(36),
    "round_number" INTEGER NOT NULL,
    "destroyed_player_card_id" VARCHAR(36) NOT NULL,
    "destroyed_by_player_card_id" VARCHAR(36),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "card_destroy_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_outcome_events" (
    "id" VARCHAR(36) NOT NULL,
    "match_id" VARCHAR(36) NOT NULL,
    "player_id" VARCHAR(36) NOT NULL,
    "match_outcome" "public"."MatchOutcome" NOT NULL,
    "finishing_round" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "match_outcome_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_shielded_hit_events" (
    "id" VARCHAR(36) NOT NULL,
    "match_id" VARCHAR(36) NOT NULL,
    "match_round_id" VARCHAR(36),
    "round_number" INTEGER NOT NULL,
    "attacker_player_card_id" VARCHAR(36),
    "target_player_card_id" VARCHAR(36),
    "target_hero_id" INTEGER,
    "damage_taken_amount" INTEGER NOT NULL,
    "shield_absorbed" INTEGER,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "match_shielded_hit_events_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "card_damage_events_match_id_attacker_player_card_id_idx" ON "public"."card_damage_events"("match_id", "attacker_player_card_id");

-- CreateIndex
CREATE INDEX "card_damage_events_attacker_player_card_id_idx" ON "public"."card_damage_events"("attacker_player_card_id");

-- CreateIndex
CREATE INDEX "card_round_damage_events_match_id_round_number_attacker_pla_idx" ON "public"."card_round_damage_events"("match_id", "round_number", "attacker_player_card_id");

-- CreateIndex
CREATE INDEX "card_round_damage_events_attacker_player_card_id_round_numb_idx" ON "public"."card_round_damage_events"("attacker_player_card_id", "round_number");

-- CreateIndex
CREATE INDEX "card_destroy_events_match_id_round_number_idx" ON "public"."card_destroy_events"("match_id", "round_number");

-- CreateIndex
CREATE INDEX "card_destroy_events_destroyed_player_card_id_idx" ON "public"."card_destroy_events"("destroyed_player_card_id");

-- CreateIndex
CREATE INDEX "match_outcome_events_finishing_round_idx" ON "public"."match_outcome_events"("finishing_round");

-- CreateIndex
CREATE INDEX "match_outcome_events_player_id_match_outcome_idx" ON "public"."match_outcome_events"("player_id", "match_outcome");

-- CreateIndex
CREATE INDEX "match_shielded_hit_events_match_id_round_number_idx" ON "public"."match_shielded_hit_events"("match_id", "round_number");
