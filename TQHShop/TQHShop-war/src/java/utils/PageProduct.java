/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package utils;

import java.util.List;
import models.ProductIndexModel;


/**
 *
 * @author tatyuki1209
 */
public class PageProduct {
    private static final int DEFAULT_PAGE_INDEX = 1;

    private int records;
    private final int recordsTotal;
    private int pageIndex;
    private int pages;
    private final List<?> origModel;
    private List<?> model;
   
    public PageProduct(List<?> model, int addRecoredPage) {
        this.origModel = model;
        this.records = addRecoredPage;
        this.pageIndex = DEFAULT_PAGE_INDEX;        
        this.recordsTotal = model.size();

        if (records > 0) {
            pages = records <= 0 ? 1 : recordsTotal / records;

            if (recordsTotal % records > 0) {
                pages++;
            }

            if (pages == 0) {
                pages = 1;
            }
        } else {
            records = 1;
            pages = 1;
        }
        if(this.pageIndex < pages) {
            this.pageIndex++;
        }
        if(this.pageIndex > 1) {
            this.pageIndex--;
        }
        updateModel();
    }

    public void updateModel() {
        int fromIndex = getFirst();
        int toIndex = getFirst() + records;

        if(toIndex > this.recordsTotal) {
            toIndex = this.recordsTotal;
        }

        this.model = (List<?>) origModel.subList(fromIndex, toIndex);
    }

    public void next() {
        if(this.pageIndex < pages) {
            this.pageIndex++;
        }

        updateModel();
    }

    public void prev() {
        if(this.pageIndex > 1) {
            this.pageIndex--;
        }

        updateModel();
    }   

    public int getRecords() {
        return records;
    }

    public void setRecords(int records) {
        this.records = records;
    }

    public int getRecordsTotal() {
        return recordsTotal;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public int getPages() {
        return pages;
    }

    public int getFirst() {
        return (pageIndex * records) - records;
    }

    public List<?> getModel() {
        return model;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }
}
