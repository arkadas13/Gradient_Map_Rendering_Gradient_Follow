clc
clear all
adjm=[1 1 1 1 1 1 
      1 0 0 0 0 0 
      1 0 1 1 1 1 
      1 0 1 1 1 1 
      1 0 0 1 0 1 
      1 1 1 1 0 1
      0 0 0 0 0 1];
count=1;countmain=2;
row=size(adjm,1);
column=size(adjm,2);
sr=7;
sc=6;
er=1;
ec=1;
presentrow=sr; 
presentcolumn=sc;
moves(count,1)=sr; moves(count,2)=sc;
while(presentrow~=er || presentcolumn~=ec)
    A = zeros(row,column);A(er,ec)=1;
    arr2=zeros(row+column,2);arr1=zeros(row+column,2);
    flag=1;count1=1;count2=1;loop=1;arr1(1,1)=er;arr1(1,2)=ec;
    while(flag==1)
        if(mod(loop,2)==1)
            count2=0;flag=0;
            for i=1:count1
                for j=-1:1
                    for k=-1:1
                        if ((j~=0 || k~=0) && arr1(i,1)+j>=1 && arr1(i,1)+j<=row && arr1(i,2)+k>=1 && arr1(i,2)+k<=column && adjm(arr1(i,1)+j,arr1(i,2)+k)==1 && exp(-sqrt(j^2+k^2))*A(arr1(i,1),arr1(i,2))>A(arr1(i,1)+j,arr1(i,2)+k))
                            arr2(count2+1,1)=arr1(i,1)+j;
                            arr2(count2+1,2)=arr1(i,2)+k;
                            count2=count2+1;
                            A(arr1(i,1)+j,arr1(i,2)+k)=exp(-sqrt(j^2+k^2))*A(arr1(i,1),arr1(i,2));
                            flag=1;
                        end
                    end
                end
            end
        else
            count1=0;flag=0;
            for i=1:count2
                for j=-1:1
                    for k=-1:1
                        if ((j~=0 || k~=0) && arr2(i,1)+j>=1 && arr2(i,1)+j<=row && arr2(i,2)+k>=1 && arr2(i,2)+k<=column && adjm(arr2(i,1)+j,arr2(i,2)+k)==1 && exp(-sqrt(j^2+k^2))*A(arr2(i,1),arr2(i,2))>A(arr2(i,1)+j,arr2(i,2)+k))
                            arr1(count1+1,1)=arr2(i,1)+j;
                            arr1(count1+1,2)=arr2(i,2)+k;
                            count1=count1+1;
                            A(arr2(i,1)+j,arr2(i,2)+k)=exp(-sqrt(j^2+k^2))*A(arr2(i,1),arr2(i,2));
                            flag=1;
                        end
                    end
                end
            end
        end
        loop=loop+1;
    end
    
    x=1:0.5:column;
    y=1:0.5:row;
    Z =(max(A(ceil(y),ceil(x))+A(floor(y),floor(x)),A(floor(y),ceil(x))+A(ceil(y),floor(x))))/2;
    figure (1)
    surf(x,y,Z);
    
    x=1:0.5:column;
    y=1:0.5:row;
    Z =log(max(A(ceil(y),ceil(x))+A(floor(y),floor(x)),A(floor(y),ceil(x))+A(ceil(y),floor(x))))/2;
    figure (2)
    surf(x,y,Z);
    count=countmain;
    while(presentrow~=er || presentcolumn~=ec)
        maxgrad=0;
        for j=-1:1
            for k=-1:1
                if ((j~=0 || k~=0) && presentrow+j>=1 && presentrow+j<=row && presentcolumn+k>=1 && ...
                        presentcolumn+k<=column && maxgrad< A(presentrow+j,presentcolumn+k)-A(presentrow,presentcolumn))
                    maxgrad= (A(presentrow+j,presentcolumn+k)-A(presentrow,presentcolumn))/(sqrt(j^2+k^2));
                    r=j;c=k;
                end
            end
        end
        
        presentrow=presentrow+r;presentcolumn=presentcolumn+c;
        moves(count,1)=presentrow;moves(count,2)=presentcolumn;
        count=count+1;
        x=linspace(1,column+0.99999,200);
        y=linspace(1,row+0.99999,200);
        Z =log(A(floor(y),floor(x)));
        figure (3)
        surf(x,y,Z)
        hold on
        for i=1:count-1
            if(i<countmain)
                if(A(moves(i,1),moves(i,2))~=0)
                    plot3(moves(i,2)+0.5,moves(i,1)+0.5,log(A(moves(i,1),moves(i,2))), 'r*');
                else
                    plot3(moves(i,2)+0.5,moves(i,1)+0.5,0, 'r*');
                end
            elseif(i==countmain)
                if(A(moves(i,1),moves(i,2))~=0)
                    plot3(moves(i,2)+0.5,moves(i,1)+0.5,log(A(moves(i,1),moves(i,2))), 'ro');
                else
                    plot3(moves(i,2)+0.5,moves(i,1)+0.5,0, 'ro');
                end
            else
                if(A(moves(i,1),moves(i,2))~=0)
                    plot3(moves(i,2)+0.5,moves(i,1)+0.5,log(A(moves(i,1),moves(i,2))), 'g*');
                else
                    plot3(moves(i,2)+0.5,moves(i,1)+0.5,0, 'g*');
                end
            end
            hold on;
        end
        hold off;
    end
    presentrow=moves(countmain,1);
    presentcolumn=moves(countmain,2);
    countmain=countmain+1;
    adjm=input('Enter New Maze:');
    disp('Enter New End Point:');
    er=input('Row:');
    ec=input('Column:');
    %{
    while(presentrow~=er || presentcolumn~=ec)
    fprintf('%d %d\n',presentrow,presentcolumn);
    maxgrad=0;
    for j=-1:1
        for k=-1:1
            if ((j~=0 || k~=0) && presentrow+j>=1 && presentrow+j<=row && presentcolumn+k>=1 && presentcolumn+k<=column && maxgrad< A(presentrow+j,presentcolumn+k)-A(presentrow,presentcolumn))
                maxgrad= (A(presentrow+j,presentcolumn+k)-A(presentrow,presentcolumn))/(sqrt(j^2+k^2));
                r=j;c=k;
            end
        end
    end
    presentrow=presentrow+r;presentcolumn=presentcolumn+c;
    end
    %}
end