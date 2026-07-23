// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleDonation {
    // 컨트랙트를 배포한 운영자 주소
    address public owner;

    // 캠페인 활성 여부
    bool public campaignActive;

    // 전체 누적 기부액
    uint256 public totalDonated;

    // 주소별 누적 기부액
    mapping(address => uint256) public donations;

    // 기부가 발생했을 때 남기는 기록
    event Donated(
        address indexed donor,
        uint256 amount
    );

    // 캠페인 상태가 변경됐을 때 남기는 기록
    event CampaignStatusChanged(
        bool active
    );

    // 컨트랙트를 배포할 때 한 번 실행
    constructor() {
        owner = msg.sender;
        campaignActive = true;
    }

    // 운영자만 실행할 수 있도록 제한
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only owner can call this function"
        );

        _;
    }

    // ETH 기부
    function donate() external payable {
        require(
            campaignActive,
            "Campaign is not active"
        );

        require(
            msg.value > 0,
            "Donation must be greater than zero"
        );

        donations[msg.sender] += msg.value;
        totalDonated += msg.value;

        emit Donated(msg.sender, msg.value);
    }

    // 캠페인 활성화 또는 중단
    function setCampaignActive(
        bool active
    )
        external
        onlyOwner
    {
        campaignActive = active;

        emit CampaignStatusChanged(active);
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