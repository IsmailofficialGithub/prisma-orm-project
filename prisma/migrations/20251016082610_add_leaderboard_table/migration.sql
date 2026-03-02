-- CreateTable
CREATE TABLE "public"."leaderboard" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "currentPosition" INTEGER NOT NULL,
    "previousPosition" INTEGER NOT NULL,
    "username" TEXT NOT NULL,
    "factionId" INTEGER NOT NULL,
    "topCards" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "leaderboard_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "leaderboard_currentPosition_idx" ON "public"."leaderboard"("currentPosition");

-- CreateIndex
CREATE INDEX "leaderboard_factionId_idx" ON "public"."leaderboard"("factionId");

-- CreateIndex
CREATE UNIQUE INDEX "leaderboard_playerId_key" ON "public"."leaderboard"("playerId");

-- AddForeignKey
ALTER TABLE "public"."leaderboard" ADD CONSTRAINT "leaderboard_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "public"."players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."leaderboard" ADD CONSTRAINT "leaderboard_factionId_fkey" FOREIGN KEY ("factionId") REFERENCES "public"."factions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
