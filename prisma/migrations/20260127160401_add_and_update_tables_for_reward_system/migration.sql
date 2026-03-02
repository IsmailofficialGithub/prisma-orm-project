/*
  Warnings:

  - You are about to drop the `bundle_rewards` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `bundles` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `missions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `reward_types` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `rewards` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."bundle_rewards" DROP CONSTRAINT "bundle_rewards_bundle_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."bundle_rewards" DROP CONSTRAINT "bundle_rewards_reward_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."missions" DROP CONSTRAINT "missions_bundle_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."missions" DROP CONSTRAINT "missions_mission_image_type_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."missions" DROP CONSTRAINT "missions_mission_type_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."player_missions_progress" DROP CONSTRAINT "player_missions_progress_mission_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."rewards" DROP CONSTRAINT "rewards_reward_type_id_fkey";

-- DropTable
DROP TABLE "public"."bundle_rewards";

-- DropTable
DROP TABLE "public"."bundles";

-- DropTable
DROP TABLE "public"."missions";

-- DropTable
DROP TABLE "public"."reward_types";

-- DropTable
DROP TABLE "public"."rewards";

-- CreateTable
CREATE TABLE "public"."Mission" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(30) NOT NULL,
    "required_progress" INTEGER NOT NULL,
    "mission_type_id" SMALLINT NOT NULL,
    "mission_image_type_id" SMALLINT NOT NULL,
    "reward_package_id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Mission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_type" (
    "id" UUID NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_asset_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset" (
    "id" UUID NOT NULL,
    "asset_type_id" UUID NOT NULL,
    "code" VARCHAR(64) NOT NULL,
    "display_name" VARCHAR(128) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "deleted_at" TIMESTAMPTZ(6),

    CONSTRAINT "reward_asset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_currency" (
    "asset_id" UUID NOT NULL,
    "currency_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_asset_currency_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_xp" (
    "asset_id" UUID NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_asset_xp_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_card" (
    "asset_id" UUID NOT NULL,
    "card_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_asset_card_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_lootbox" (
    "asset_id" UUID NOT NULL,
    "lootbox_type_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_asset_lootbox_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_package" (
    "id" UUID NOT NULL,
    "code" VARCHAR(64) NOT NULL,
    "display_name" VARCHAR(128) NOT NULL,
    "description" VARCHAR(512),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_package_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_package_status" (
    "id" UUID NOT NULL,
    "code" VARCHAR(16) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_package_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_package_version" (
    "id" UUID NOT NULL,
    "package_id" UUID NOT NULL,
    "version" INTEGER NOT NULL,
    "status_id" UUID NOT NULL,
    "valid_from" TIMESTAMPTZ(6),
    "valid_to" TIMESTAMPTZ(6),
    "created_by" UUID,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_package_version_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_package_line" (
    "id" UUID NOT NULL,
    "package_version_id" UUID NOT NULL,
    "asset_id" UUID NOT NULL,
    "quantity" BIGINT NOT NULL,
    "choice_group_id" UUID,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_package_line_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_choice_group" (
    "id" UUID NOT NULL,
    "package_version_id" UUID NOT NULL,
    "selection_count" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_choice_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_source_type" (
    "id" UUID NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_source_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_state" (
    "id" UUID NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_grant_state_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant" (
    "id" UUID NOT NULL,
    "player_id" UUID NOT NULL,
    "package_version_id" UUID NOT NULL,
    "source_type_id" UUID NOT NULL,
    "source_ref" VARCHAR(128),
    "state_id" UUID NOT NULL,
    "idempotency_key" VARCHAR(96) NOT NULL,
    "payload_snapshot" JSONB NOT NULL,
    "fulfilled_at" TIMESTAMPTZ(6),
    "claimed_at" TIMESTAMPTZ(6),
    "reversed_at" TIMESTAMPTZ(6),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_grant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_line" (
    "id" UUID NOT NULL,
    "grant_id" UUID NOT NULL,
    "asset_id" UUID NOT NULL,
    "quantity" BIGINT NOT NULL,
    "package_line_id" UUID,
    "choice_group_id" UUID,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_grant_line_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_event_type" (
    "id" UUID NOT NULL,
    "code" VARCHAR(32) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_grant_event_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_event" (
    "id" UUID NOT NULL,
    "grant_id" UUID NOT NULL,
    "event_type_id" UUID NOT NULL,
    "event_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actor_id" UUID,
    "metadata" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "reward_grant_event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."player_ledger_entry" (
    "id" UUID NOT NULL,
    "player_id" UUID NOT NULL,
    "asset_id" UUID NOT NULL,
    "delta" BIGINT NOT NULL,
    "grant_line_id" UUID,
    "reason" VARCHAR(64),
    "occurred_at" TIMESTAMPTZ(6) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "player_ledger_entry_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "reward_asset_type_code_key" ON "public"."reward_asset_type"("code");

-- CreateIndex
CREATE INDEX "reward_asset_type_code_idx" ON "public"."reward_asset_type"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_asset_code_key" ON "public"."reward_asset"("code");

-- CreateIndex
CREATE INDEX "reward_asset_asset_type_id_idx" ON "public"."reward_asset"("asset_type_id");

-- CreateIndex
CREATE INDEX "reward_asset_is_active_idx" ON "public"."reward_asset"("is_active");

-- CreateIndex
CREATE INDEX "reward_asset_currency_currency_id_idx" ON "public"."reward_asset_currency"("currency_id");

-- CreateIndex
CREATE UNIQUE INDEX "reward_asset_xp_code_key" ON "public"."reward_asset_xp"("code");

-- CreateIndex
CREATE INDEX "reward_asset_card_card_id_idx" ON "public"."reward_asset_card"("card_id");

-- CreateIndex
CREATE INDEX "reward_asset_lootbox_lootbox_type_id_idx" ON "public"."reward_asset_lootbox"("lootbox_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "reward_package_code_key" ON "public"."reward_package"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_package_status_code_key" ON "public"."reward_package_status"("code");

-- CreateIndex
CREATE INDEX "reward_package_version_package_id_idx" ON "public"."reward_package_version"("package_id");

-- CreateIndex
CREATE INDEX "reward_package_version_status_id_idx" ON "public"."reward_package_version"("status_id");

-- CreateIndex
CREATE UNIQUE INDEX "reward_package_version_package_id_version_key" ON "public"."reward_package_version"("package_id", "version");

-- CreateIndex
CREATE INDEX "reward_package_line_package_version_id_idx" ON "public"."reward_package_line"("package_version_id");

-- CreateIndex
CREATE INDEX "reward_package_line_asset_id_idx" ON "public"."reward_package_line"("asset_id");

-- CreateIndex
CREATE INDEX "reward_package_line_choice_group_id_idx" ON "public"."reward_package_line"("choice_group_id");

-- CreateIndex
CREATE INDEX "reward_choice_group_package_version_id_idx" ON "public"."reward_choice_group"("package_version_id");

-- CreateIndex
CREATE UNIQUE INDEX "reward_source_type_code_key" ON "public"."reward_source_type"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_grant_state_code_key" ON "public"."reward_grant_state"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_grant_idempotency_key_key" ON "public"."reward_grant"("idempotency_key");

-- CreateIndex
CREATE INDEX "reward_grant_player_id_idx" ON "public"."reward_grant"("player_id");

-- CreateIndex
CREATE INDEX "reward_grant_source_type_id_idx" ON "public"."reward_grant"("source_type_id");

-- CreateIndex
CREATE INDEX "reward_grant_state_id_idx" ON "public"."reward_grant"("state_id");

-- CreateIndex
CREATE INDEX "reward_grant_line_grant_id_idx" ON "public"."reward_grant_line"("grant_id");

-- CreateIndex
CREATE INDEX "reward_grant_line_asset_id_idx" ON "public"."reward_grant_line"("asset_id");

-- CreateIndex
CREATE INDEX "reward_grant_line_package_line_id_idx" ON "public"."reward_grant_line"("package_line_id");

-- CreateIndex
CREATE INDEX "reward_grant_line_choice_group_id_idx" ON "public"."reward_grant_line"("choice_group_id");

-- CreateIndex
CREATE UNIQUE INDEX "reward_grant_event_type_code_key" ON "public"."reward_grant_event_type"("code");

-- CreateIndex
CREATE INDEX "reward_grant_event_grant_id_idx" ON "public"."reward_grant_event"("grant_id");

-- CreateIndex
CREATE INDEX "reward_grant_event_event_type_id_idx" ON "public"."reward_grant_event"("event_type_id");

-- CreateIndex
CREATE INDEX "player_ledger_entry_player_id_idx" ON "public"."player_ledger_entry"("player_id");

-- CreateIndex
CREATE INDEX "player_ledger_entry_asset_id_idx" ON "public"."player_ledger_entry"("asset_id");

-- DataCleanup
-- Drop legacy player mission progress to avoid FK violations after missions table replacement.
TRUNCATE TABLE "public"."player_missions_progress";

-- AddForeignKey
ALTER TABLE "public"."Mission" ADD CONSTRAINT "Mission_mission_type_id_fkey" FOREIGN KEY ("mission_type_id") REFERENCES "public"."mission_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Mission" ADD CONSTRAINT "Mission_mission_image_type_id_fkey" FOREIGN KEY ("mission_image_type_id") REFERENCES "public"."mission_image_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Mission" ADD CONSTRAINT "Mission_reward_package_id_fkey" FOREIGN KEY ("reward_package_id") REFERENCES "public"."reward_package"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_missions_progress" ADD CONSTRAINT "player_missions_progress_mission_id_fkey" FOREIGN KEY ("mission_id") REFERENCES "public"."Mission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset" ADD CONSTRAINT "reward_asset_asset_type_id_fkey" FOREIGN KEY ("asset_type_id") REFERENCES "public"."reward_asset_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_currency" ADD CONSTRAINT "reward_asset_currency_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_xp" ADD CONSTRAINT "reward_asset_xp_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_card" ADD CONSTRAINT "reward_asset_card_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_lootbox" ADD CONSTRAINT "reward_asset_lootbox_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_version" ADD CONSTRAINT "reward_package_version_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "public"."reward_package"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_version" ADD CONSTRAINT "reward_package_version_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "public"."reward_package_status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_line" ADD CONSTRAINT "reward_package_line_package_version_id_fkey" FOREIGN KEY ("package_version_id") REFERENCES "public"."reward_package_version"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_line" ADD CONSTRAINT "reward_package_line_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_choice_group" ADD CONSTRAINT "reward_choice_group_package_version_id_fkey" FOREIGN KEY ("package_version_id") REFERENCES "public"."reward_package_version"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant" ADD CONSTRAINT "reward_grant_source_type_id_fkey" FOREIGN KEY ("source_type_id") REFERENCES "public"."reward_source_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant" ADD CONSTRAINT "reward_grant_state_id_fkey" FOREIGN KEY ("state_id") REFERENCES "public"."reward_grant_state"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant" ADD CONSTRAINT "reward_grant_package_version_id_fkey" FOREIGN KEY ("package_version_id") REFERENCES "public"."reward_package_version"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_line" ADD CONSTRAINT "reward_grant_line_grant_id_fkey" FOREIGN KEY ("grant_id") REFERENCES "public"."reward_grant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_line" ADD CONSTRAINT "reward_grant_line_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_line" ADD CONSTRAINT "reward_grant_line_package_line_id_fkey" FOREIGN KEY ("package_line_id") REFERENCES "public"."reward_package_line"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_line" ADD CONSTRAINT "reward_grant_line_choice_group_id_fkey" FOREIGN KEY ("choice_group_id") REFERENCES "public"."reward_choice_group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_event" ADD CONSTRAINT "reward_grant_event_grant_id_fkey" FOREIGN KEY ("grant_id") REFERENCES "public"."reward_grant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_event" ADD CONSTRAINT "reward_grant_event_event_type_id_fkey" FOREIGN KEY ("event_type_id") REFERENCES "public"."reward_grant_event_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_ledger_entry" ADD CONSTRAINT "player_ledger_entry_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_ledger_entry" ADD CONSTRAINT "player_ledger_entry_grant_line_id_fkey" FOREIGN KEY ("grant_line_id") REFERENCES "public"."reward_grant_line"("id") ON DELETE SET NULL ON UPDATE CASCADE;
