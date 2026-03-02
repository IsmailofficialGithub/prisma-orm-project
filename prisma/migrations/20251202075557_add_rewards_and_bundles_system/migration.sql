/*
  Warnings:

  - You are about to drop the column `lc_reward` on the `missions` table. All the data in the column will be lost.
  - You are about to drop the column `xp_reward` on the `missions` table. All the data in the column will be lost.
  - Added the required column `bundle_id` to the `missions` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."mission_image_types" ALTER COLUMN "name" SET DATA TYPE VARCHAR(25);

-- AlterTable
ALTER TABLE "public"."missions" DROP COLUMN "lc_reward",
DROP COLUMN "xp_reward",
ADD COLUMN     "bundle_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "public"."rewards" (
    "id" SERIAL NOT NULL,
    "reward_type_id" SMALLINT NOT NULL,
    "amount" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "rewards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."reward_types" (
    "id" SMALLINT NOT NULL,
    "name" VARCHAR(25) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reward_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."bundles" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "bundles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."bundle_rewards" (
    "reward_id" INTEGER NOT NULL,
    "bundle_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "bundle_rewards_pkey" PRIMARY KEY ("reward_id","bundle_id")
);

-- AddForeignKey
ALTER TABLE "public"."missions" ADD CONSTRAINT "missions_bundle_id_fkey" FOREIGN KEY ("bundle_id") REFERENCES "public"."bundles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."rewards" ADD CONSTRAINT "rewards_reward_type_id_fkey" FOREIGN KEY ("reward_type_id") REFERENCES "public"."reward_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."bundle_rewards" ADD CONSTRAINT "bundle_rewards_reward_id_fkey" FOREIGN KEY ("reward_id") REFERENCES "public"."rewards"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."bundle_rewards" ADD CONSTRAINT "bundle_rewards_bundle_id_fkey" FOREIGN KEY ("bundle_id") REFERENCES "public"."bundles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
