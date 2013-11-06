Archive = require("./archive")

numKyokus = 0
numTsumos = 0
numTurnsFreqs = (0 for _ in [0...18])
for path in process.argv[2...]
  #console.log(path)
  archive = new Archive(path)
  archive.play (action) =>
    #console.log(action.toJson())
    switch action.type
      when "tsumo"
        ++numTsumos
      when "end_kyoku"
        ++numKyokus
        ++numTurnsFreqs[Math.floor(numTsumos / 4)]
        numTsumos = 0
      when "error"
        throw new Error("error in the log: #{path}")
stats = {
  numTurnsDistribution: (f / numKyokus for f in numTurnsFreqs),
}
console.log(JSON.stringify(stats))
