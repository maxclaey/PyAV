from libc.stdint cimport uint32_t, uint64_t, int64_t

cdef extern from "libavformat/rtsp.h" nogil:
    ctypedef struct RTSPStream:
        void *transport_priv

    ctypedef struct RTSPState:
        RTSPStream **rtsp_streams

    ctypedef struct RTPDemuxContext:
        AVStream *st
        uint32_t timestamp
        uint32_t base_timestamp
        int64_t  unwrapped_timestamp
        int64_t  range_start_offset
        uint64_t last_rtcp_ntp_time
        uint64_t first_rtcp_ntp_time
        uint32_t last_rtcp_timestamp
        int64_t rtcp_ts_offset;
