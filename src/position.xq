xquery version "3.0";

(:~
: User: George Sofianos
: Benchmark number 2 - position and result timing
: Engine: BaseX
:)

declare function local:test($r, $limit) {
    if (count($r) > $limit) then
        ($r[position() = 1 to $limit], <test></test>)
    else
        $r
};

let $x := prof:track(for $x in 1 to 100000
return <test>xxx</test>, map { 'value':false()})

let $z := prof:track((for $x in 1 to 100000
return <test>xxx</test>)[position() = 1 to 100], map { 'value':false()})

let $t := prof:track(local:test(for $x in 1 to 100000 return <test>xxx</test>, 100), map { 'value':false()})

return ($x, $z, $t)