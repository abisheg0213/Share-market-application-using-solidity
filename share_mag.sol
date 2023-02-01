pragma solidity ^0.4.0;
contract share_market
{
    struct company
    {
        uint no_of_shares;
        uint rate;
        uint revenue;
    }
    struct investor
    {
        uint total_invesments;
        uint amount_spend;
        uint amount_rev;
        uint profit;
    }
    uint starttime;
    mapping (uint  => company) shares;
    address share_market_head;
    address trade_executive;
    mapping (uint=>investor) investors;
    function share_market()
    {
        share_market_head=msg.sender;
        starttime=now;
    }
    modifier onlyhead(address s)
    {
        require(s==share_market_head);
        _;
    }
     modifier onlyte(address s)
    {
        require(s==trade_executive);
        _;
    }
    function addcompany(uint cid,uint r) public onlyhead(msg.sender)
    {
        shares[cid].no_of_shares=0;
        shares[cid].rate=r;
        shares[cid].revenue=0;
    }
    function register_invs(uint i) public onlyte(msg.sender)
    {
        investors[i].total_invesments=0;
        investors[i].amount_spend=0;
        investors[i].amount_rev=0;
        investors[i].profit=0;
    }
    function make_inves(uint inv_id,uint compid,uint no) public
    {
        if(now>(starttime+10 seconds))
        {
            shares[compid].rate=shares[compid].rate+10;
            starttime=now;
        }
        if(now>(starttime+120 seconds))
        {
            shares[compid].rate=shares[compid].rate-100;
            starttime=now;
        }
        investors[inv_id].total_invesments=no;
        investors[inv_id].amount_spend+=(shares[compid].rate*no);
        shares[compid].no_of_shares+=no;
        shares[compid].revenue+=(shares[compid].rate*no);
    }
    function revert_inves(uint inv_id,uint compid,uint no) public
    {
     investors[inv_id].total_invesments-=no;
        investors[inv_id].amount_rev+=(shares[compid].rate*no);
        investors[inv_id].profit=investors[inv_id].amount_rev- investors[inv_id].amount_spend;  
    }
}
