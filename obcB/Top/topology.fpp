module obcB {

  # ----------------------------------------------------------------------
  # Symbolic constants for port numbers
  # ----------------------------------------------------------------------

    enum b_Ports_RateGroups {
      rateGroup1
      rateGroup2
      rateGroup3
    }

  topology obcB {

    # ----------------------------------------------------------------------
    # Instances used in the topology
    # ----------------------------------------------------------------------

    instance b_health
    instance b_blockDrv
    instance b_tlmSend
    instance b_cmdDisp
    instance b_cmdSeq
    instance b_comDriver
    instance b_comQueue
    instance b_comStub
    instance b_deframer
    instance b_eventLogger
    instance b_fatalAdapter
    instance b_fatalHandler
    instance b_fileDownlink
    instance b_fileManager
    instance b_fileUplink
    instance b_bufferManager
    instance b_framer
    instance b_posixTime
    instance b_prmDb
    instance b_rateGroup1
    instance b_rateGroup2
    instance b_rateGroup3
    instance b_rateGroupDriver
    instance b_textLogger
    instance b_systemResources

    instance b_hub
    instance b_hubComDriver
    instance b_hubComStub
    instance b_hubComQueue
    instance b_hubDeframer
    instance b_hubFramer

    # ----------------------------------------------------------------------
    # Pattern graph specifiers
    # ----------------------------------------------------------------------

    command connections instance b_cmdDisp

    event connections instance b_hub 

    param connections instance b_prmDb

    telemetry connections instance b_hub

    text event connections instance b_textLogger

    time connections instance b_posixTime

    health connections instance b_health

    # ----------------------------------------------------------------------
    # Direct graph specifiers
    # ----------------------------------------------------------------------

    # connections Downlink {

    #   b_eventLogger.PktSend -> b_comQueue.comQueueIn[0]
    #   b_tlmSend.PktSend -> b_comQueue.comQueueIn[1]
    #   b_fileDownlink.bufferSendOut -> b_comQueue.buffQueueIn[0]

    #   b_comQueue.comQueueSend -> b_framer.comIn
    #   b_comQueue.buffQueueSend -> b_framer.bufferIn

    #   b_framer.framedAllocate -> b_bufferManager.bufferGetCallee
    #   b_framer.framedOut -> b_comStub.comDataIn
    #   b_framer.bufferDeallocate -> b_fileDownlink.bufferReturn

    #   b_comDriver.deallocate -> b_bufferManager.bufferSendIn
    #   b_comDriver.ready -> b_comStub.drvConnected

    #   b_comStub.comStatus -> b_framer.comStatusIn
    #   b_framer.comStatusOut -> b_comQueue.comStatusIn
    #   b_comStub.drvDataOut -> b_comDriver.$send

    # }

    # connections FaultProtection {
    #   b_eventLogger.FatalAnnounce -> b_fatalHandler.FatalReceive
    # }

    connections RateGroups {
      # Block driver
      b_blockDrv.CycleOut -> b_rateGroupDriver.CycleIn

      # Rate group 1
      b_rateGroupDriver.CycleOut[b_Ports_RateGroups.rateGroup1] -> b_rateGroup1.CycleIn
      # b_rateGroup1.RateGroupMemberOut[0] -> b_tlmSend.Run
      b_rateGroup1.RateGroupMemberOut[0] -> b_fileDownlink.Run

      # Rate group 2
      b_rateGroupDriver.CycleOut[b_Ports_RateGroups.rateGroup2] -> b_rateGroup2.CycleIn
      b_rateGroup2.RateGroupMemberOut[0] -> b_bufferManager.schedIn
      # b_rateGroup2.RateGroupMemberOut[0] -> b_cmdSeq.schedIn

      # Rate group 3
      b_rateGroupDriver.CycleOut[b_Ports_RateGroups.rateGroup3] -> b_rateGroup3.CycleIn
      b_rateGroup3.RateGroupMemberOut[0] -> b_health.Run
      b_rateGroup3.RateGroupMemberOut[1] -> b_blockDrv.Sched
      b_rateGroup3.RateGroupMemberOut[2] -> b_systemResources.run
    }

    # connections Sequencer {
    #   b_cmdSeq.comCmdOut -> b_cmdDisp.seqCmdBuff
    #   b_cmdDisp.seqCmdStatus -> b_cmdSeq.cmdResponseIn
    # }

    # connections Uplink {

    #   b_comDriver.allocate -> b_bufferManager.bufferGetCallee
    #   b_comDriver.$recv -> b_comStub.drvDataIn
    #   b_comStub.comDataOut -> b_deframer.framedIn

    #   b_deframer.framedDeallocate -> b_bufferManager.bufferSendIn
    #   b_deframer.comOut -> b_cmdDisp.seqCmdBuff

    #   b_cmdDisp.seqCmdStatus -> b_deframer.cmdResponseIn

    #   b_deframer.bufferAllocate -> b_bufferManager.bufferGetCallee
    #   b_deframer.bufferOut -> b_fileUplink.bufferSendIn
    #   b_deframer.bufferDeallocate -> b_bufferManager.bufferSendIn
    #   b_fileUplink.bufferSendOut -> b_bufferManager.bufferSendIn
    # }

    connections obcB {
      # Add here connections to user-defined components
    }

    connections send_hub {
      # b_hub.dataOut -> b_hubComQueue.buffQueueIn
      b_hub.dataOut -> b_hubFramer.bufferIn
      b_hub.dataOutAllocate -> b_bufferManager.bufferGetCallee
      
      # b_hubComQueue.buffQueueSend -> b_hubFramer.bufferIn
      # b_hubComQueue.comQueueSend -> b_hubFramer.comIn

      # b_hubFramer.framedOut -> b_hubComStub.comDataIn
      b_hubFramer.framedOut -> b_hubComDriver.$send
      # b_hubFramer.comStatusOut -> b_comQueue.comStatusIn
      b_hubFramer.bufferDeallocate -> b_bufferManager.bufferSendIn
      b_hubFramer.framedAllocate -> b_bufferManager.bufferGetCallee
      
      # b_hubComStub.comStatus -> b_hubFramer.comStatusIn
      # b_hubComStub.drvDataOut -> b_hubComDriver.$send

      b_hubComDriver.deallocate -> b_bufferManager.bufferSendIn
      # b_hubComDriver.ready -> b_comStub.drvConnected
    }

    connections recv_hub {
      # b_hubComDriver.$recv -> b_hubComStub.drvDataIn
      b_hubComDriver.$recv -> b_hubDeframer.framedIn
      b_hubComDriver.allocate -> b_bufferManager.bufferGetCallee

      # b_hubComStub.comDataOut -> b_hubDeframer.framedIn

      # b_cmdDisp.seqCmdStatus -> b_hubDeframer.cmdResponseIn
       
      b_hubDeframer.bufferOut -> b_hub.dataIn
      # b_hubDeframer.comOut -> b_cmdDisp.seqCmdBuff
      b_hubDeframer.bufferAllocate -> b_bufferManager.bufferGetCallee
      b_hubDeframer.framedDeallocate -> b_bufferManager.bufferSendIn

      b_hub.dataInDeallocate -> b_bufferManager.bufferSendIn
    }

    connections hub {
      b_hub.portOut[0] -> b_cmdDisp.seqCmdBuff
      b_hub.portOut[1] -> b_fileDownlink.bufferReturn
       
      b_cmdDisp.seqCmdStatus -> b_hub.portIn[0]
      b_fileDownlink.bufferSendOut -> b_hub.portIn[1]

      b_hub.buffersOut -> b_bufferManager.bufferSendIn
    }

  }

}
