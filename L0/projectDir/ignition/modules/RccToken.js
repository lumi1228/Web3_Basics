const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const INITIAL_SUPPLY = 1_000_000_000_000_000_000_000_000n; // 1 million tokens

module.exports = buildModule("RccTokenModule", (m) => {
  const rccToken = m.contract("RccToken", [INITIAL_SUPPLY]);

  return { rccToken };
}); 