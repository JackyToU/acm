Const
  Fin='Code.inp';			{�����ļ���}
  Fou='Code.out';			{����ļ���}

Type
  Us=array[1..1000] of integer;		{��������˵��}

Var
  F:text;				{�ļ�����}
  C,d,t1,t2:longint;			{ʱ�̱���}
  N:integer;				{���볤��}
  Dan,Zi1,Zi2:us;			{��¼��������ı���}
  Use,U1,U2,Mid,P,Q:us;			{��¼��������Ӧ�õı���}

  Procedure Init;			{��ʼ�����̣���������}
   Var
     i:integer;
     j:longint;
    Begin
       Assign(f,fin);
       reset(f);
         readln(f,n,c);
          read(f,t1);
          For i:=1 to n do
             read(f,zi1[i]);
          readln(f);
          read(f,t2);
          for i:=1 to n do
            read(f,zi2[i]);
          if t1<t2 then
           Begin
              use:=zi1;zi1:=zi2;
              zi2:=use;
              j:=t1;t1:=t2;t2:=j;
           end;
       close(f);
    end;

  Procedure Main;			{������}
  var
      i,j:integer;

         Function Euclid(t1,t2:Longint):Longint;	{�����������Լ����Euclid�㷨}
         var
             x:longint;
           Begin
             while t1 mod t2>0 do
               Begin
                 x:=t2;
                 t2:=t1 mod t2;
                 t1:=x;
               end;
             euclid:=t2;
           end;

         Procedure Jia(Var P:us;Z:us);			{���ӷ�����Ӧ������任}
         Var
            i:integer;
           Begin
              q:=p;
              for i:=1 to n do
                p[i]:=q[z[i]];
           End;

         Procedure Jian(Var P:us;Z:us);			{����������Ӧ������任}
           Var
             i:integer;
             Begin
               q:=p;
               For i:=1 to n do
                p[z[i]]:=q[i];
             End;

        Procedure Cheng(Var Zi:us;K:longint);		{���˷�����Ӧ������任}
        Var
          i:integer;

          Begin
            for i:=1 to n do
              p[i]:=i;

             While K>0 do				{���á������ơ��������}
               Begin
                 If  k mod 2=1 Then
                     jia(p,zi);
                 k:=k div 2;
                 jia(zi,zi);
               End;
             zi:=p;
          End;

        Procedure Euclid_Big(T1,T2:Longint);		{��Euclid�㷨������ת������}
         Var
             X,K:Longint;
          Begin
            While t1 mod t2<>0 do
              Begin
                x:=t2;
                k:=t1 div t2;
                t2:=t1 mod t2;
                t1:=x;

                use:=zi2;
                cheng(use,k);
                jian(zi1,use);

                mid:=zi2;
                zi2:=zi1;
                zi1:=mid;
              End;
             dan:=zi2;
          end;

    Begin
       D:=euclid(t1,t2);
       Assign(f,fou);
       Rewrite(f);
       If C mod D<>0 Then			{�޽����}
          writeln(F,'No Answer')
         Else
           Begin
              c:=c div d;			
              euclid_big(t1,t2);		{���Ӧ���Լ��D������}	
              cheng(dan,c);			{���ó˷����}	
              For i:=1 to n do
                Write(f,dan[i],' ');		{���}
           End;
       Close(f);
    end;

Begin			{������}
   Init;		{��������}			
   Main;		{����}
End.