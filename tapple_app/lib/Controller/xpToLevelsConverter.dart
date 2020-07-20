class LevelInfo {
  final int level;
  final int remainingXP;
  final double levelAndFraction;
  LevelInfo(this.level,this.remainingXP, this.levelAndFraction);
}
final Set<int> LEVEL_2_10_EXP = { 225, 1025, 1750, 3750, 4750, 6000, 8250, 10250, 12750};
final int LEVEL_11_50_EXP = 13500;
final int LEVEL_51_AND_UP_EXP = 15000;

LevelInfo getLevelInfo(int totalXp)
{
  int xpLeft = totalXp;
  int level = 1;

  /* Level 2 - 10 */
  for (int levelRequirement in LEVEL_2_10_EXP)
  {
    if (xpLeft >= levelRequirement)
    {
      level++;
      xpLeft -= levelRequirement;
    }
    else
    {
      double fraction = xpLeft.toDouble() /  levelRequirement.toDouble();

      return new LevelInfo(level, xpLeft, (level + fraction).toDouble());
    }
  }

  /* Level 11 - 50 */
  for (int i = 0; i < 40; i++)
  {
    if (xpLeft > LEVEL_11_50_EXP)
    {
      level++;
      xpLeft -= LEVEL_11_50_EXP;
    }
    else
    {
      double fraction = xpLeft.toDouble() / LEVEL_11_50_EXP.toDouble();

      return new LevelInfo(level, xpLeft, (level + fraction).toDouble());
    }
  }

  /* Level 51+ */
  int additionalLevels = xpLeft ~/ LEVEL_51_AND_UP_EXP;
  level += additionalLevels;

  xpLeft %= LEVEL_51_AND_UP_EXP;
  double fraction = xpLeft.toDouble() / LEVEL_51_AND_UP_EXP.toDouble();

  return new LevelInfo(level, xpLeft, (level + fraction).toDouble());
}