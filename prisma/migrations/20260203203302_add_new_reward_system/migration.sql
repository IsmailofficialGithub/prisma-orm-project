-- CreateTable
CREATE TABLE "public"."reward_asset_type" (
    "id" UUID NOT NULL,
    "code" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_asset_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset" (
    "id" UUID NOT NULL,
    "asset_type_id" UUID NOT NULL,
    "code" VARCHAR(100) NOT NULL,
    "display_name" VARCHAR(255) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_asset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_currency" (
    "asset_id" UUID NOT NULL,
    "currency_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_asset_currency_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_xp" (
    "asset_id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_asset_xp_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_card" (
    "asset_id" UUID NOT NULL,
    "card_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_asset_card_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_asset_lootbox" (
    "asset_id" UUID NOT NULL,
    "lootbox_type_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_asset_lootbox_pkey" PRIMARY KEY ("asset_id")
);

-- CreateTable
CREATE TABLE "public"."reward_source_type" (
    "id" UUID NOT NULL,
    "code" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_source_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_state" (
    "id" UUID NOT NULL,
    "code" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_grant_state_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant" (
    "id" UUID NOT NULL,
    "player_id" TEXT NOT NULL,
    "source_type_id" UUID NOT NULL,
    "source_ref" VARCHAR(255),
    "state_id" UUID NOT NULL,
    "idempotency_key" VARCHAR(255) NOT NULL,
    "payload_snapshot" JSONB,
    "fulfilled_at" TIMESTAMP(3),
    "claimed_at" TIMESTAMP(3),
    "reversed_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_grant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_line" (
    "id" UUID NOT NULL,
    "grant_id" UUID NOT NULL,
    "asset_id" UUID NOT NULL,
    "quantity" INTEGER NOT NULL,
    "package_line_id" UUID,
    "choice_group_id" UUID,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_grant_line_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_event_type" (
    "id" UUID NOT NULL,
    "code" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_grant_event_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_grant_event" (
    "id" UUID NOT NULL,
    "grant_id" UUID NOT NULL,
    "event_type_id" UUID NOT NULL,
    "event_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actor_id" UUID,
    "metadata" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_grant_event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."player_ledger_entry" (
    "id" UUID NOT NULL,
    "player_id" TEXT NOT NULL,
    "asset_id" UUID NOT NULL,
    "delta" INTEGER NOT NULL,
    "grant_line_id" UUID,
    "reason" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "player_ledger_entry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_package_status" (
    "id" UUID NOT NULL,
    "code" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_package_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_package" (
    "id" UUID NOT NULL,
    "code" VARCHAR(100) NOT NULL,
    "display_name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_package_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_package_version" (
    "id" UUID NOT NULL,
    "package_id" UUID NOT NULL,
    "status_id" UUID NOT NULL,
    "version" INTEGER NOT NULL DEFAULT 1,
    "valid_from" TIMESTAMP(3),
    "valid_to" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_package_version_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_package_line" (
    "id" UUID NOT NULL,
    "package_version_id" UUID NOT NULL,
    "asset_id" UUID NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "choice_group_id" UUID,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_package_line_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_choice_group" (
    "id" UUID NOT NULL,
    "package_version_id" UUID NOT NULL,
    "selection_count" INTEGER NOT NULL DEFAULT 1,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_choice_group_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "reward_asset_type_code_key" ON "public"."reward_asset_type"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_asset_code_key" ON "public"."reward_asset"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_asset_xp_code_key" ON "public"."reward_asset_xp"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_source_type_code_key" ON "public"."reward_source_type"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_grant_state_code_key" ON "public"."reward_grant_state"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_grant_idempotency_key_key" ON "public"."reward_grant"("idempotency_key");

-- CreateIndex
CREATE UNIQUE INDEX "reward_grant_event_type_code_key" ON "public"."reward_grant_event_type"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_package_status_code_key" ON "public"."reward_package_status"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_package_code_key" ON "public"."reward_package"("code");

-- CreateIndex
CREATE UNIQUE INDEX "reward_package_version_package_id_version_key" ON "public"."reward_package_version"("package_id", "version");

-- AddForeignKey
ALTER TABLE "public"."reward_asset" ADD CONSTRAINT "reward_asset_asset_type_id_fkey" FOREIGN KEY ("asset_type_id") REFERENCES "public"."reward_asset_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_currency" ADD CONSTRAINT "reward_asset_currency_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_xp" ADD CONSTRAINT "reward_asset_xp_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_card" ADD CONSTRAINT "reward_asset_card_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_asset_lootbox" ADD CONSTRAINT "reward_asset_lootbox_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant" ADD CONSTRAINT "reward_grant_source_type_id_fkey" FOREIGN KEY ("source_type_id") REFERENCES "public"."reward_source_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant" ADD CONSTRAINT "reward_grant_state_id_fkey" FOREIGN KEY ("state_id") REFERENCES "public"."reward_grant_state"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant" ADD CONSTRAINT "reward_grant_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_line" ADD CONSTRAINT "reward_grant_line_grant_id_fkey" FOREIGN KEY ("grant_id") REFERENCES "public"."reward_grant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_line" ADD CONSTRAINT "reward_grant_line_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_event" ADD CONSTRAINT "reward_grant_event_grant_id_fkey" FOREIGN KEY ("grant_id") REFERENCES "public"."reward_grant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_grant_event" ADD CONSTRAINT "reward_grant_event_event_type_id_fkey" FOREIGN KEY ("event_type_id") REFERENCES "public"."reward_grant_event_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_ledger_entry" ADD CONSTRAINT "player_ledger_entry_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_ledger_entry" ADD CONSTRAINT "player_ledger_entry_grant_line_id_fkey" FOREIGN KEY ("grant_line_id") REFERENCES "public"."reward_grant_line"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_ledger_entry" ADD CONSTRAINT "player_ledger_entry_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_version" ADD CONSTRAINT "reward_package_version_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "public"."reward_package"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_version" ADD CONSTRAINT "reward_package_version_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "public"."reward_package_status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_line" ADD CONSTRAINT "reward_package_line_package_version_id_fkey" FOREIGN KEY ("package_version_id") REFERENCES "public"."reward_package_version"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_line" ADD CONSTRAINT "reward_package_line_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."reward_asset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_package_line" ADD CONSTRAINT "reward_package_line_choice_group_id_fkey" FOREIGN KEY ("choice_group_id") REFERENCES "public"."reward_choice_group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."reward_choice_group" ADD CONSTRAINT "reward_choice_group_package_version_id_fkey" FOREIGN KEY ("package_version_id") REFERENCES "public"."reward_package_version"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
