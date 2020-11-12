from libc.stdint cimport uint32_t, uint64_t

cdef extern from "libavformat/rtsp.h" nogil:
    ctypedef struct RTSPStream:
        void *transport_priv

    ctypedef struct RTSPState:
        RTSPStream **rtsp_streams

    ctypedef struct RTPDemuxContext:
        AVStream *st
        uint32_t timestamp
        uint32_t base_timestamp
        uint32_t cur_timestamp
        uint64_t last_rtcp_ntp_time
        uint64_t first_rtcp_ntp_time
        uint32_t last_rtcp_timestamp
