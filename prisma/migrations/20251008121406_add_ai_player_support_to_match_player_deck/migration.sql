-- DropForeignKey
ALTER TABLE "public"."match_player_decks" DROP CONSTRAINT "match_player_decks_playerDeckId_fkey";

-- DropForeignKey
ALTER TABLE "public"."match_player_decks" DROP CONSTRAINT "match_player_decks_playerId_fkey";

-- AlterTable
ALTER TABLE "public"."match_player_decks" ADD COLUMN     "aiPlayerData" JSONB,
ADD COLUMN     "isAiPlayer" BOOLEAN NOT NULL DEFAULT false,
ALTER COLUMN "playerId" DROP NOT NULL,
ALTER COLUMN "playerDeckId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "public"."match_player_decks" ADD CONSTRAINT "match_player_decks_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_player_decks" ADD CONSTRAINT "match_player_decks_playerDeckId_fkey" FOREIGN KEY ("playerDeckId") REFERENCES "public"."decks"("id") ON DELETE SET NULL ON UPDATE CASCADE;
