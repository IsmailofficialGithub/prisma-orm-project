/*
  Warnings:

  - You are about to drop the column `heroHealEligible` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `p1AttackingCards` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `p2AttackingCards` on the `matches` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."matches" 
DROP COLUMN "heroHealEligible",
DROP COLUMN "p1AttackingCards",
DROP COLUMN "p2AttackingCards";
