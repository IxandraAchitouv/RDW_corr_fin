# double_loop.pyx

import numpy as np
cimport numpy as np

def filter_edges(np.ndarray[double, ndim=2] Mg, double quantile_value):
    cdef int k, v
    cdef double w
    cdef list e = []
    cdef list nodes = []
    cdef double thresh = np.quantile(Mg,quantile_value)

    for k in range(Mg.shape[0]):
        for v in range(k):
            w = Mg[k, v]
            if abs(w) > thresh and v != k:
                e.append((k, v, {'weight': w}))
                if k not in nodes:
                    nodes.append(k)
                if v not in nodes:
                    nodes.append(v)

    return e, nodes



