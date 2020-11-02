import json

from rest_framework import filters
from rest_framework.pagination import PageNumberPagination


class PETSearchFilter(filters.SearchFilter):
    '''
    Search class. Allows specifying subset of search fields declared
    in a view class.
    ?search_fields=["param1","param2"]
    '''
    def get_search_fields(self, view, request):
        search_fields = request.query_params.get('search_fields')
        declared_fields = super().get_search_fields(view, request)
        if search_fields:
            search_fields = json.loads(search_fields)
            if set(search_fields).issubset(set(declared_fields)):
                return search_fields
        return declared_fields


class PETPagination(PageNumberPagination):
    '''
    Pagination class. Allows specifying pagination page size on
    a per-request basis.
    '''
    page_query_param = 'page'
    page_size_query_param = 'page_size'
