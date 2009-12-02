Const
  Max=10000;				{�������}
  Fin='Sort.Inp';			{�����ļ���}
  Fou='Sort.Out';			{����ļ���}

Type
   Zis=array[1..max] of Real;		{��������˵��}

Var
   Tot:longint;				{������ԡ�����}
   N:integer;				{�����С}
   Zi,Use:^zis;				{��¼���е�����}
   F:Text;				{�ļ�����˵��}

  Procedure Init;			{��ʼ�����̣���������}
  Var
    i:integer;
    Begin
      New(zi);
      New(use);
      Assign(f,fin);
      Reset(f);
        Readln(f,n);
        For i:=1 to n do
          read(f,zi^[i]);
      Close(f);
    end;

   Procedure Sort(l,R:integer);		{���ù鲢����������ԡ�}
     Var
       T:integer;
						
          Procedure Merge(l,t,r:integer);	
		   {�������ź�������顰�鲢����һ��ͬʱ����󲿷�������Ҳ��֡�����ԡ�����Ŀ}
          Var
            i,j,k:integer;
            Begin
              i:=l;
              j:=T+1;
              k:=l-1;
              While (i<=t) and (j<=r) do
                Begin
                  if zi^[i]<zi^[j] then
                    Begin
                      inc(tot,j-t-1);	{��Ծ�ۼӡ�����ԡ���Ŀ}
                      inc(k);
                      use^[k]:=zi^[i];
                      inc(i);
                    end
                  Else
                    Begin
                      inc(k);
                      use^[k]:=zi^[j];
                      inc(j);
                    end;
                end;

              while i<=t do		{ʣ�ಿ�ֵ�β����}
                Begin
                  inc(k);
                  use^[k]:=zi^[i];
                  inc(i);
                  inc(tot,r-t);
                end;
              while j<=r do
               Begin
                 inc(k);
                 use^[k]:=zi^[j];
                 inc(j);
               end;

              Move(use^[l],zi^[l],(r-l+1)*6);{������������Ĺ鲢�����������}
            end;
        Begin
          if l<r then
           Begin
             t:=(l+r) div 2;		{���֡�}
             Sort(l,t);			{���֡����֡��Ρ�}
             Sort(t+1,r);
             Merge(l,t,r);		{���ϡ�}
           end;
        end;

 Procedure Print;			{������}
   Begin
     Assign(F,fou);
     rewrite(f);
       Writeln(f,tot);
     Close(f);
   end;

Begin			{������}
  Init;					{��������}
  Tot:=0;
  Sort(1,n);				{���}
  Print;				{������}
end.
