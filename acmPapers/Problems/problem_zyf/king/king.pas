{$M 65520,0,655360}
{$R-,S-,Q-}

const
  Finp          ='Input.txt';
  Fout          ='Output.txt';
  Max           =100;

type
  TSet          =record{����(����)�����ݽṹ}
                k,st,ed :Integer
  end;
  TStr          =string[100];

var
  S             :array[1..Max] of TStr;
  Checked       :array[1..Max] of Boolean;
  n             :Integer;
  MaxCount,King :Integer;

procedure GetInfo;{��������}
  var
    i   :Integer;
  begin
    Assign(Input,Finp);Reset(Input);
    Readln(n);
    for i:=1 to n do Readln(S[i]);
    Close(Input)
  end;

procedure Get(var x:TSet);{����Ԫ��}
  var
    Depth       :Integer;
  begin
    if S[x.k,x.st]=',' then Inc(x.st);
    x.ed:=x.st;
    if S[x.k,x.ed]='(' then begin
      Depth:=1;
      repeat
        Inc(x.ed);
        if S[x.k,x.ed]='(' then Inc(Depth);
        if S[x.k,x.ed]=')' then Dec(Depth)
      until Depth=0
    end else while S[x.k,x.ed+1] in ['0'..'9'] do Inc(x.ed)
  end;

function Equal(p,q:TSet):Boolean;forward;

function Include(p,q:TSet):Boolean;{�жϼ���p�Ƿ���q�а�����ϵ����ϸ�����ⱨ��}
  var
    x,y         :TSet;
    Quit        :Boolean;
  begin
    Include:=False;
    x.k:=p.k;
    x.st:=p.st+1;
    repeat
      Get(x);
      Quit:=True;
      y.k:=q.k;
      y.st:=q.st+1;
      repeat
        Get(y);
        if Equal(x,y) then Quit:=False;
        y.st:=y.ed+1
      until not Quit or (y.st=q.ed);
      if Quit then Exit;
      x.st:=x.ed+1
    until x.st=p.ed;
    Include:=True
  end;

function Equal(p,q:TSet):Boolean;{�жϼ���p��q�Ƿ���ȣ���ϸ�����ⱨ��}
  begin
    Equal:=(Copy(S[p.k],p.st,p.ed-p.st+1)=Copy(S[q.k],q.st,q.ed-q.st+1)) or
           (S[p.k,p.st]='(') and (S[q.k,q.st]='(') and
           Include(p,q) and Include(q,p)
  end;

procedure Prepare;{ȥ�������0}
  var
    i,k :Integer;
  begin
    for i:=1 to n do begin
      k:=1;
      while k<>Length(S[i]) do
        if (S[i,k]='0') and
           not (S[i,k-1] in ['0'..'9']) and
           (S[i,k+1] in ['0'..'9']) then Delete(S[i],k,1) else Inc(k)
    end
  end;

procedure Main;{�ҵ������ظ���������}
  var
    i,j,Count   :Integer;
    x,y         :TSet;
  begin
    FillChar(Checked,Sizeof(Checked),False);
    MaxCount:=0;
    for i:=1 to n do
      if not Checked[i] then begin
        Checked[i]:=True;
        Count:=1;
        for j:=i+1 to n do
          if not Checked[j] then begin
            x.k:=i;x.st:=1;x.ed:=Length(S[i]);
            y.k:=j;y.st:=1;y.ed:=Length(S[j]);
            if Equal(x,y) then begin
              Inc(Count);
              Checked[j]:=True
            end
          end;
        if Count>MaxCount then begin
          MaxCount:=Count;
          King:=i
        end
      end
  end;

procedure Print;{������}
  begin
    Assign(Output,Fout);Rewrite(Output);
    Writeln(MaxCount);
    Writeln(King);
    Close(Output)
  end;

begin
  GetInfo;
  Prepare;
  Main;
  Print
end.
