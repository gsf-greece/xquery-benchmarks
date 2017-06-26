xquery version "3.0";

(:~
: User: George Sofianos
: Benchmark number 1 - Native map vs Custom Map creation
: Engine: BaseX
:)

let $num := 100000

(: Result - B1: 33ms - 15MB RAM :)
let $B1 :=
    prof:mem(prof:time(
        map:merge(for $i at $pos in 1 to $num let $v := $num - $pos return map { $i : $v}, map {'duplicates': 'combine'})
    , true(), "B1: "), true(), "B1: ")

(: Result - B1-custom: 65ms - 280B RAM :)
let $B1-custom :=
    prof:mem(prof:time((
        let $map :=
        for $i at $pos in 1 to $num
            let $v := $num - $pos
            return $i || "||" || string-join($v, "##")
        for $i in $map
            let $key := substring-before($i, "||")
            let $values := substring-after($i, "||")
        group by $key
        where count($i) > 1
        return $key || "||" || string-join($values, "##"))
    , true(), "B1-custom: "), true(), "B1-custom: ")
return ($B1, $B1-custom)