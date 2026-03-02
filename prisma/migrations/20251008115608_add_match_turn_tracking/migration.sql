-- AlterTable
ALTER TABLE "public"."matches" ADD COLUMN     "currentPlayerTurn" TEXT DEFAULT 'p1',
ADD COLUMN     "heroHp" JSONB,
ADD COLUMN     "playerActionsUsed" JSONB,
ADD COLUMN     "playerRoundEnergy" JSONB;

-- AlterTable
ALTER TABLE "public"."player_match_deck_cards" ADD COLUMN     "currentHp" INTEGER,
ADD COLUMN     "hasShield" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "slotIndex" INTEGER;
