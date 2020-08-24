function OutputM=LJ_Reshape(InputM,Num_nodes,Num_windows)

OutputM=zeros(Num_windows,Num_nodes*(Num_nodes-1)/2);
for i=1:Num_windows
    tmp=squareform(InputM(:,:,i));
    OutputM(i,:)=tmp;
end





