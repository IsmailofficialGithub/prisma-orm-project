-- CreateTable
CREATE TABLE "public"."player_xp_gains" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "xpAmount" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "player_xp_gains_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."player_xp_gains" ADD CONSTRAINT "player_xp_gains_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;
