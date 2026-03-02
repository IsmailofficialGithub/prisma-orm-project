-- AlterTable
ALTER TABLE "public"."match_round_actions" ADD COLUMN     "targetHeroId" INTEGER;

-- AddForeignKey
ALTER TABLE "public"."match_round_actions" ADD CONSTRAINT "match_round_actions_targetHeroId_fkey" FOREIGN KEY ("targetHeroId") REFERENCES "public"."heroes"("id") ON DELETE SET NULL ON UPDATE CASCADE;
