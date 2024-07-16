module obcB {
  constant CMD_SPLITTER_OFFSET = 0x10000

  # ----------------------------------------------------------------------
  # Defaults
  # ----------------------------------------------------------------------

  module Default {
    constant QUEUE_SIZE = 10
    constant STACK_SIZE = 64 * 1024
  }

  # ----------------------------------------------------------------------
  # Active component instances
  # ----------------------------------------------------------------------

  instance b_blockDrv: Drv.BlockDriver base id CMD_SPLITTER_OFFSET + 0x5100 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 140

  instance b_rateGroup1: Svc.ActiveRateGroup base id CMD_SPLITTER_OFFSET + 0x5200 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 120

  instance b_rateGroup2: Svc.ActiveRateGroup base id CMD_SPLITTER_OFFSET + 0x5300 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 119

  instance b_rateGroup3: Svc.ActiveRateGroup base id CMD_SPLITTER_OFFSET + 0x5400 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 118

  instance b_cmdDisp: Svc.CommandDispatcher base id CMD_SPLITTER_OFFSET + 0x5500 \
    queue size 20 \
    stack size Default.STACK_SIZE \
    priority 101

  instance b_cmdSeq: Svc.CmdSequencer base id CMD_SPLITTER_OFFSET + 0x5600 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 100

  instance b_comQueue: Svc.ComQueue base id CMD_SPLITTER_OFFSET + 0x5700 \
      queue size Default.QUEUE_SIZE \
      stack size Default.STACK_SIZE \
      priority 100 \

  instance b_fileDownlink: Svc.FileDownlink base id CMD_SPLITTER_OFFSET + 0x5800 \
    queue size 30 \
    stack size Default.STACK_SIZE \
    priority 100

  instance b_fileManager: Svc.FileManager base id CMD_SPLITTER_OFFSET + 0x5900 \
    queue size 30 \
    stack size Default.STACK_SIZE \
    priority 100

  instance b_fileUplink: Svc.FileUplink base id CMD_SPLITTER_OFFSET + 0x5A00 \
    queue size 30 \
    stack size Default.STACK_SIZE \
    priority 100

  instance b_eventLogger: Svc.ActiveLogger base id CMD_SPLITTER_OFFSET + 0x5B00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 98

  # comment in Svc.TlmChan or Svc.TlmPacketizer
  # depending on which form of telemetry downlink
  # you wish to use

  instance b_tlmSend: Svc.TlmChan base id CMD_SPLITTER_OFFSET + 0x5C00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 97

  #instance b_tlmSend: Svc.TlmPacketizer base id CMD_SPLITTER_OFFSET + 0x5C00 \
  #    queue size Default.QUEUE_SIZE \
  #    stack size Default.STACK_SIZE \
  #    priority 97

  instance b_prmDb: Svc.PrmDb base id CMD_SPLITTER_OFFSET + 0x5D00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 96

  instance b_hubComQueue: Svc.ComQueue base id CMD_SPLITTER_OFFSET + 0x9500 \
      queue size Default.QUEUE_SIZE \
      stack size Default.STACK_SIZE \
      priority 100 \

  instance b_proxySequencer: Components.CmdSequenceForwarder base id CMD_SPLITTER_OFFSET + 0x9700 \
      queue size Default.QUEUE_SIZE \
      stack size Default.STACK_SIZE \
      priority 100 \

  instance b_proxyGroundInterface: Components.CmdSequenceForwarder base id CMD_SPLITTER_OFFSET + 0x9800 \
      queue size Default.QUEUE_SIZE \
      stack size Default.STACK_SIZE \
      priority 100 \

  # ----------------------------------------------------------------------
  # Queued component instances
  # ----------------------------------------------------------------------

  instance b_health: Svc.Health base id CMD_SPLITTER_OFFSET + 0x6000 \
    queue size 25

  # ----------------------------------------------------------------------
  # Passive component instances
  # ----------------------------------------------------------------------

  @ Communications driver. May be swapped with other com drivers like UART or TCP
  instance b_comDriver: Drv.TcpServer base id CMD_SPLITTER_OFFSET + 0x7000

  instance b_framer: Svc.Framer base id CMD_SPLITTER_OFFSET + 0x7100

  instance b_fatalAdapter: Svc.AssertFatalAdapter base id CMD_SPLITTER_OFFSET + 0x7200

  instance b_fatalHandler: Svc.FatalHandler base id CMD_SPLITTER_OFFSET + 0x7300

  instance b_bufferManager: Svc.BufferManager base id CMD_SPLITTER_OFFSET + 0x7400

  instance b_posixTime: Svc.PosixTime base id CMD_SPLITTER_OFFSET + 0x7500

  instance b_rateGroupDriver: Svc.RateGroupDriver base id CMD_SPLITTER_OFFSET + 0x7600

  instance b_textLogger: Svc.PassiveTextLogger base id CMD_SPLITTER_OFFSET + 0x7800

  instance b_deframer: Svc.Deframer base id CMD_SPLITTER_OFFSET + 0x7900

  instance b_systemResources: Svc.SystemResources base id CMD_SPLITTER_OFFSET + 0x7A00

  instance b_comStub: Svc.ComStub base id CMD_SPLITTER_OFFSET + 0x7B00

  instance b_hub: Svc.GenericHub base id CMD_SPLITTER_OFFSET + 0x9000

  instance b_hubComDriver: Drv.TcpClient base id CMD_SPLITTER_OFFSET + 0x9100
  
  instance b_hubComStub: Svc.ComStub base id CMD_SPLITTER_OFFSET + 0x9200

  instance b_hubDeframer: Svc.Deframer base id CMD_SPLITTER_OFFSET + 0x9300

  instance b_hubFramer: Svc.Framer base id CMD_SPLITTER_OFFSET + 0x9400


}
