-- CreateTable
CREATE TABLE "public"."factions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "factions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."card_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "card_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."stages" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."cards" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "active" TEXT,
    "attack" INTEGER NOT NULL,
    "cost" INTEGER NOT NULL,
    "defense" INTEGER NOT NULL,
    "factionId" INTEGER NOT NULL,
    "isToken" BOOLEAN NOT NULL DEFAULT false,
    "passive" TEXT,
    "stageId" INTEGER NOT NULL,
    "tags" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "typeId" INTEGER NOT NULL,
    "ultimate" TEXT,

    CONSTRAINT "cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."currency_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "kind" TEXT NOT NULL,
    "decimals" INTEGER NOT NULL DEFAULT 0,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "currency_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."currencies" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "currencyTypeId" INTEGER NOT NULL,

    CONSTRAINT "currencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."decks" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "decks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."deck_cards" (
    "id" TEXT NOT NULL,
    "deckId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "deck_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_inventories" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_inventories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."item_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "item_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."items" (
    "id" SERIAL NOT NULL,
    "item_type_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."item_prices" (
    "id" SERIAL NOT NULL,
    "amount" DOUBLE PRECISION,
    "itemId" INTEGER NOT NULL,

    CONSTRAINT "item_prices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lootbox_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "lootbox_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lootboxes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "lootbox_type_id" INTEGER NOT NULL,
    "currency_type_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "lootboxes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lootbox_rarities" (
    "id" SERIAL NOT NULL,
    "lootboxId" INTEGER NOT NULL,
    "rarityId" INTEGER NOT NULL,
    "dropRate" DOUBLE PRECISION,

    CONSTRAINT "lootbox_rarities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."orders" (
    "id" SERIAL NOT NULL,
    "lootboxId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "currencyTypeId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."payment_intents" (
    "id" SERIAL NOT NULL,
    "orderId" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "currencyTypeId" INTEGER NOT NULL,
    "providerReference" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payment_intents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."rank_tiers" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "rank_tiers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ranks" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "achievedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "points" INTEGER NOT NULL DEFAULT 0,
    "rankTierId" INTEGER NOT NULL,

    CONSTRAINT "ranks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Rarity" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Rarity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."transactions" (
    "id" SERIAL NOT NULL,
    "paymentIntentId" INTEGER NOT NULL,
    "wallet" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "currencyTypeId" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "transactionHash" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."users" (
    "id" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "factions_name_key" ON "public"."factions"("name");

-- CreateIndex
CREATE UNIQUE INDEX "card_types_name_key" ON "public"."card_types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "stages_name_key" ON "public"."stages"("name");

-- CreateIndex
CREATE UNIQUE INDEX "cards_name_key" ON "public"."cards"("name");

-- CreateIndex
CREATE UNIQUE INDEX "currency_types_name_key" ON "public"."currency_types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "currency_types_code_key" ON "public"."currency_types"("code");

-- CreateIndex
CREATE UNIQUE INDEX "currencies_userId_currencyTypeId_key" ON "public"."currencies"("userId", "currencyTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "deck_cards_deckId_cardId_key" ON "public"."deck_cards"("deckId", "cardId");

-- CreateIndex
CREATE UNIQUE INDEX "user_inventories_userId_cardId_key" ON "public"."user_inventories"("userId", "cardId");

-- CreateIndex
CREATE UNIQUE INDEX "item_types_name_key" ON "public"."item_types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "items_name_key" ON "public"."items"("name");

-- CreateIndex
CREATE UNIQUE INDEX "lootboxes_name_key" ON "public"."lootboxes"("name");

-- CreateIndex
CREATE UNIQUE INDEX "lootbox_rarities_lootboxId_rarityId_key" ON "public"."lootbox_rarities"("lootboxId", "rarityId");

-- CreateIndex
CREATE UNIQUE INDEX "rank_tiers_name_key" ON "public"."rank_tiers"("name");

-- CreateIndex
CREATE UNIQUE INDEX "rank_tiers_order_key" ON "public"."rank_tiers"("order");

-- CreateIndex
CREATE UNIQUE INDEX "Rarity_name_key" ON "public"."Rarity"("name");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "public"."users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "public"."users"("email");

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_factionId_fkey" FOREIGN KEY ("factionId") REFERENCES "public"."factions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_stageId_fkey" FOREIGN KEY ("stageId") REFERENCES "public"."stages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cards" ADD CONSTRAINT "cards_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES "public"."card_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."currencies" ADD CONSTRAINT "currencies_currencyTypeId_fkey" FOREIGN KEY ("currencyTypeId") REFERENCES "public"."currency_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."currencies" ADD CONSTRAINT "currencies_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."decks" ADD CONSTRAINT "decks_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deck_cards" ADD CONSTRAINT "deck_cards_deckId_fkey" FOREIGN KEY ("deckId") REFERENCES "public"."decks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_inventories" ADD CONSTRAINT "user_inventories_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_inventories" ADD CONSTRAINT "user_inventories_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."items" ADD CONSTRAINT "items_item_type_id_fkey" FOREIGN KEY ("item_type_id") REFERENCES "public"."item_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."item_prices" ADD CONSTRAINT "item_prices_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "public"."items"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lootboxes" ADD CONSTRAINT "lootboxes_lootbox_type_id_fkey" FOREIGN KEY ("lootbox_type_id") REFERENCES "public"."lootbox_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lootboxes" ADD CONSTRAINT "lootboxes_currency_type_id_fkey" FOREIGN KEY ("currency_type_id") REFERENCES "public"."currency_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lootbox_rarities" ADD CONSTRAINT "lootbox_rarities_lootboxId_fkey" FOREIGN KEY ("lootboxId") REFERENCES "public"."lootboxes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lootbox_rarities" ADD CONSTRAINT "lootbox_rarities_rarityId_fkey" FOREIGN KEY ("rarityId") REFERENCES "public"."Rarity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_lootboxId_fkey" FOREIGN KEY ("lootboxId") REFERENCES "public"."lootboxes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."orders" ADD CONSTRAINT "orders_currencyTypeId_fkey" FOREIGN KEY ("currencyTypeId") REFERENCES "public"."currency_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."payment_intents" ADD CONSTRAINT "payment_intents_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "public"."orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."payment_intents" ADD CONSTRAINT "payment_intents_currencyTypeId_fkey" FOREIGN KEY ("currencyTypeId") REFERENCES "public"."currency_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ranks" ADD CONSTRAINT "ranks_rankTierId_fkey" FOREIGN KEY ("rankTierId") REFERENCES "public"."rank_tiers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ranks" ADD CONSTRAINT "ranks_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."transactions" ADD CONSTRAINT "transactions_paymentIntentId_fkey" FOREIGN KEY ("paymentIntentId") REFERENCES "public"."payment_intents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."transactions" ADD CONSTRAINT "transactions_currencyTypeId_fkey" FOREIGN KEY ("currencyTypeId") REFERENCES "public"."currency_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
