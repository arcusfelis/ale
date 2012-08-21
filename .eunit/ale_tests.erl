-module(ale_tests).

-compile({parse_transform, ale}).
-compile(export_all).


%% SELECT name, AVG(test_score) FROM student GROUP BY name;
group_by() ->
    [{S.name, average(S.test_scrote)}
        || S <- table(student), group(S.name)].

%% UPDATE TABLE xyz SET y=z WHERE y=x;
update() ->
    [[y = Z|XYZ]
        || [z = Z|XYZ] <- table(xyz)].

update2() ->
    [[y = XYZ.z|XYZ]
        || XYZ <- table(xyz)].


%% SELECT table1.* FROM table1 
%%      LEFT JOIN table2 ON table1.id = tabke2.id WHERE table2.id IS NULL
left_join() ->
    [T1 || T1 <- table(table1), 
           T2 <- join_table(table2), T1.id == T2.id, T2.id =:= undefined].

%% SELECT student.name COUNT(*) FROM student, course 
%%     WHERE student.id = course.student_id GROUP BY student.name;
count() ->
    [{Name, count()}
        || S <- table(student),
           C <- table(course), S.id == C.id, group(S.name)].


%% SELECT * FROM t1 ORDER BY f1;
order_by() ->
    [T || T <- table(t1), order(T.f1)].


%% SELECT * FROM t1 ORDER BY f1 DESC;
order_by_desc() ->
    [T || T <- table(t1), order(reverse(T.f1))].

%% SELECT * FROM t1 ORDER BY f1, f2;
order_by_multi() ->
    [ T || T <- table(t1), sort([T.f1, T.f2]) ].

%% SELECT * FROM t1 ORDER BY f1 DESC, f2 DESC;
order_by_multi_desc() ->
    [ T || T <- table(t1), sort(reverse([T.f1, T.f2])) ].

%% SELECT * FROM t1 ORDER BY f1 DESC, f2;
order_by_multi_desc2() ->
    [ T || T <- table(t1), sort([reverse(T.f1), T.f2]) ].


%% SELECT * FROM t1 LIMIT 10, 20;
limit() ->
    [ T || T <- table(t1), limit(10), offset(20) ].


%% SELECT `group`.name, `group`.id, count(client.id) FROM `group` 
%%    LEFT JOIN client ON client.group_id = `group`.id
%%        GROUP BY `group`.id HAVING count(client.id) > 3;
%%
%% Use having with:
%%  AVG() - Returns the average value
%%  COUNT() - Returns the number of rows
%%  FIRST() - Returns the first value
%%  LAST() - Returns the last value
%%  MAX() - Returns the largest value
%%  MIN() - Returns the smallest value
%%  SUM() - Returns the sum
having() ->
    [ {G.name, G.id, CC} 
        || G <- table(group), 
           C <- join_table(client), 
           CC = count(C.id),
           group(G.id), C.group_id == G.id, CC > 3].

%% COALESCE(A = B, A IS NULL AND B IS NULL)
is_exact_equal() ->
    A =:= B.

%% COALESCE(A != B, A IS NOT NULL AND B IS NOT NULL)
not_exact_equal() ->
    A =/= B.
