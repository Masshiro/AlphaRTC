#include "cmdinfer.h"

#include "modules/third_party/statcollect/json.hpp"

#include <iostream>
#include <fstream>


const char * RequestBandwidthCommand = "RequestBandwidth";
// const char * BandwidthLogFile = "./bandwidth_log.txt";


// static void LogBandwidthToFile(const nlohmann::json& j) {
//     std::ofstream log_file;
//     log_file.open(BandwidthLogFile, std::ios_base::app);  // 以追加模式打开文件
//     if (log_file.is_open()) {
//         log_file << j.dump() << std::endl;  // 将 JSON 数据写入文件
//         log_file.close();
//     } else {
//         std::cerr << "Unable to open bandwidth_log.txt file!" << std::endl;
//     }
// }

void cmdinfer::ReportStates(
    std::uint64_t sendTimeMs,
    std::uint64_t receiveTimeMs,
    std::size_t payloadSize,
    std::uint8_t payloadType,
    std::uint16_t sequenceNumber,
    std::uint32_t ssrc,
    std::size_t paddingLength,
    std::size_t headerLength) {

    nlohmann::json j;
    j["send_time_ms"] = sendTimeMs;
    j["arrival_time_ms"] = receiveTimeMs;
    j["payload_type"] = payloadType;
    j["sequence_number"] = sequenceNumber;
    j["ssrc"] = ssrc;
    j["padding_length"] = paddingLength;
    j["header_length"] = headerLength;
    j["payload_size"] = payloadSize;

    std::cout << j.dump() << std::endl;
}

float cmdinfer::GetEstimatedBandwidth() {
    std::uint64_t bandwidth = 0;
    std::cout << RequestBandwidthCommand << std::endl;
    std::cin >> bandwidth;

    // nlohmann::json j;
    // j["estimated_bandwidth"] = bandwidth;
    // LogBandwidthToFile(j);

    return static_cast<float>(bandwidth);
}
