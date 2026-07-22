// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleDonation {
    uint256 public totalDonated;

    mapping(address => uint256) public donations;

    function donate() external payable {
        require(
            msg.value > 0,
            "Donation must be greater than zero"
        );

        donations[msg.sender] += msg.value;
        totalDonated += msg.value;
    }

    // 전체 누적 기부액을 ETH 단위로 조회
    function getTotalDonatedInEther()
        external
        view
        returns (uint256)
    {
        return totalDonated / 1 ether;
    }

    // 현재 계정의 누적 기부액을 ETH 단위로 조회
    function getMyDonationInEther()
        external
        view
        returns (uint256)
    {
        return donations[msg.sender] / 1 ether;
    }
}