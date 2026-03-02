-- AlterTable
ALTER TABLE "public"."matches" ADD COLUMN     "p1AttackingCards" UUID[],
ADD COLUMN     "p2AttackingCards" UUID[];
