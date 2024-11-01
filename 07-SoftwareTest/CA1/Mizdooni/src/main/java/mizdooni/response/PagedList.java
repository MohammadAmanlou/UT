package mizdooni.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import mizdooni.response.serializer.ListSizeSerializer;

import java.util.Collections;
import java.util.List;

public class PagedList<T> {
    @JsonProperty
    private int page;
    private int size;
    private int start;
    private int end;
    private List<T> original;
    @JsonProperty("size")
    @JsonSerialize(using = ListSizeSerializer.class)
    private List<T> pageList;

    public PagedList(List<T> original, int page, int size) {
        if (page < 1 || size < 1) {
            throw new IllegalArgumentException("invalid page number");
        }
        this.page = page;
        this.size = size;
        this.original = original;
        this.start = (page - 1) * size;
        this.end = Math.min(start + size, original.size());
        if (this.start >= original.size()) {
            this.pageList = Collections.emptyList();
        } else {
            this.pageList = original.subList(start, end);
        }
    }

    @JsonProperty
    public boolean hasNext() {
        return end < original.size();
    }

    @JsonProperty
    public int totalPages() {
        return (int) Math.ceil((double) original.size() / size);
    }

    @JsonProperty("pageList")
    public List<T> getPageList() {
        return pageList;
    }
}
