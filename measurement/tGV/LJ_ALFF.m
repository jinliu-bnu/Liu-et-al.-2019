function OutputM=LJ_ALFF(InputM,Num_nodes,ind)
          [X, Y]=PlotFreq(InputM, 0.72);
        OutputM=squareform(mean(Y(2:ind,:),1));


