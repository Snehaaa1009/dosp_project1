use "collections"


actor Main
  new create(env: Env) =>
    try
      let args = env.args
      let n = args(1)?.i64()?
      let k = args(2)?.i64()?
      
      let boss = Boss(n, k, env)
      boss.assign_work()
    else
      env.out.print("provide the input") 
    end

actor Boss
  let n_input: I64
  let k_input: I64
  let _env: Env
  var _results: Array[I64] = []
  var _expected: I64
  var _completed: I64 = 0

  new create(n: I64, k: I64, env: Env) =>
    n_input = n
    k_input = k
    _env = env
    _expected = n

be assign_work() =>

  var workers: I64 = 200
  if n_input < 200  then
    workers = n_input
  end

  var work_size: I64 = n_input / workers
  let remainder: I64 = n_input % workers
  var ranges: Array[(I64, I64)] = []

  _env.out.print("workers: " + workers.string())
  _env.out.print("work_size: " + work_size.string())

  var start: I64 = 1

  if (((n_input % 2) != 0) or ((workers % 2) != 0)) and (remainder != 0) then
    // Apply sliding window by adjusting the last chunk
    for i in Range[I64](0, workers - 1) do
      let ending: I64 = (i + 1) * work_size
      ranges.push((start, ending))
      start = ending + 1
    end
    ranges.push((start, n_input))
  else
    for i in Range[I64](0, workers) do
      let ending: I64 = (i + 1) * work_size
      ranges.push((start, ending))
      start = ending + 1
    end
  end
  _env.out.print("Output")
  for j in ranges.values() do
    let worker = Worker(this, _env)
    worker.process_work(j._1, j._2, k_input)
  end

  

actor Worker
  let _boss: Boss
  let _env: Env


  new create(boss: Boss,env: Env) =>
    _boss = boss
    _env = env

  be process_work(start: I64, ending: I64, k: I64) =>
    for i in Range[I64](start, ending+1) do
      if sum_of_perfect_squares(i, k) then
        _env.out.print(i.string())
      end
    end

  fun sum_of_perfect_squares(start: I64, k: I64): Bool =>
    var sum: I64 = 0
    for i in Range[I64](start, (start + k)) do
      sum = sum + (i * i)
    end

    let sqr_root = integer_root(sum)

    (sqr_root * sqr_root) == sum

fun integer_root(n: I64): I64 =>
  if n == 0 then
    0
  else
    var x: I64 = n
    var y: I64 = (x + (n / x)) / 2
    while y < x do
      x = y
      y = (x + (n / x)) / 2
    end
    x
  end