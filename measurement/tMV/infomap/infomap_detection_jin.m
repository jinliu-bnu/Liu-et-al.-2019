function infomap_detection_jin(path1,thr,outputname,name)

temp=load(path1);
 for j=1:size(temp.FC_dyn,3)
   tmp=temp.FC_dyn(:,:,j);
   tmp(find(tmp<0))=0;
   [A,~]=gretna_R2b(tmp,'s',thr);
   ind{j}=find(sum(A)==0);
   A=A.*tmp;
   [com] = infomap(A,name);
   Com(:,j)=com;
 end
  save(outputname,'Com','ind')
