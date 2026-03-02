-- CreateTable
CREATE TABLE "public"."action_types" (
    "id" SERIAL NOT NULL,
    "typeName" TEXT NOT NULL,

    CONSTRAINT "action_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."matches" (
    "id" TEXT NOT NULL,
    "turnOrder" JSONB[],
    "currentRound" INTEGER NOT NULL DEFAULT 1,
    "status" TEXT NOT NULL DEFAULT 'active',
    "winner" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "matches_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_player_decks" (
    "id" TEXT NOT NULL,
    "matchId" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "playerDeckId" TEXT NOT NULL,
    "deckPosition" INTEGER NOT NULL,

    CONSTRAINT "match_player_decks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."player_match_deck_cards" (
    "id" TEXT NOT NULL,
    "matchPlayerDeckId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "cardPosition" INTEGER NOT NULL,
    "isInHand" BOOLEAN NOT NULL DEFAULT false,
    "isPlayed" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "player_match_deck_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_rounds" (
    "id" TEXT NOT NULL,
    "matchId" TEXT NOT NULL,
    "roundNumber" INTEGER NOT NULL,
    "currentPlayerId" TEXT,
    "roundStartTime" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "roundEndTime" TIMESTAMP(3),

    CONSTRAINT "match_rounds_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_round_energies" (
    "id" TEXT NOT NULL,
    "matchRoundId" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "energyAmount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "match_round_energies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_round_actions" (
    "id" TEXT NOT NULL,
    "matchRoundId" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "actionTypeId" INTEGER NOT NULL,
    "targetCardId" TEXT,
    "actionData" JSONB,
    "actionTimestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "match_round_actions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_summaries" (
    "id" TEXT NOT NULL,
    "matchId" TEXT NOT NULL,
    "totalRounds" INTEGER NOT NULL,
    "matchDuration" INTEGER NOT NULL,
    "winCondition" TEXT NOT NULL,
    "finalScore" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "match_summaries_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "action_types_typeName_key" ON "public"."action_types"("typeName");

-- CreateIndex
CREATE UNIQUE INDEX "match_summaries_matchId_key" ON "public"."match_summaries"("matchId");

-- AddForeignKey
ALTER TABLE "public"."match_player_decks" ADD CONSTRAINT "match_player_decks_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "public"."matches"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_player_decks" ADD CONSTRAINT "match_player_decks_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_player_decks" ADD CONSTRAINT "match_player_decks_playerDeckId_fkey" FOREIGN KEY ("playerDeckId") REFERENCES "public"."decks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_match_deck_cards" ADD CONSTRAINT "player_match_deck_cards_matchPlayerDeckId_fkey" FOREIGN KEY ("matchPlayerDeckId") REFERENCES "public"."match_player_decks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."player_match_deck_cards" ADD CONSTRAINT "player_match_deck_cards_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "public"."cards"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_rounds" ADD CONSTRAINT "match_rounds_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "public"."matches"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_rounds" ADD CONSTRAINT "match_rounds_currentPlayerId_fkey" FOREIGN KEY ("currentPlayerId") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_energies" ADD CONSTRAINT "match_round_energies_matchRoundId_fkey" FOREIGN KEY ("matchRoundId") REFERENCES "public"."match_rounds"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_energies" ADD CONSTRAINT "match_round_energies_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_matchRoundId_fkey" FOREIGN KEY ("matchRoundId") REFERENCES "public"."match_rounds"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_actionTypeId_fkey" FOREIGN KEY ("actionTypeId") REFERENCES "public"."action_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_targetCardId_fkey" FOREIGN KEY ("targetCardId") REFERENCES "public"."cards"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_summaries" ADD CONSTRAINT "match_summaries_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "public"."matches"("id") ON DELETE CASCADE ON UPDATE CASCADE;
