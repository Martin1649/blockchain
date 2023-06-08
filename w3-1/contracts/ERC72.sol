pragma solidity ^0.4.20;

// @title ERC-721非同质化代币标准
// @dev See https://learnblockchain.cn/docs/eips/eip-721.html
//  Note: ERC-165 接口id 为 0x80ac58cd.
interface ERC721 /* is ERC165 */ {
    // @dev 当任何NFT的所有权更改时（不管哪种方式），就会触发此事件。
    //  包括在创建时（`from` == 0）和销毁时(`to` == 0), 合约创建时除外。
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    // @dev 当更改或确认NFT的授权地址时触发。
    //  零地址表示没有授权的地址。
    //  发生 `Transfer` 事件时，同样表示该NFT的授权地址（如果有）被重置为“无”（零地址）。
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

    // @dev 所有者启用或禁用操作员时触发。（操作员可管理所有者所持有的NFTs）
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    // @notice 统计所持有的NFTs数量
    // @dev NFT 不能分配给零地址，查询零地址同样会异常
    // @param _owner ： 待查地址
    // @return 返回数量，也许是0
    function balanceOf(address _owner) external view returns (uint256);

    // @notice 返回所有者
    // @dev NFT 不能分配给零地址，查询零地址抛出异常
    // @param _tokenId NFT 的id
    // @return 返回所有者地址
    function ownerOf(uint256 _tokenId) external view returns (address);

    // @notice 将NFT的所有权从一个地址转移到另一个地址
    // @dev 如果`msg.sender` 不是当前的所有者（或授权者）抛出异常
    // 如果 `_from` 不是所有者、`_to` 是零地址、`_tokenId` 不是有效id 均抛出异常。
    //  当转移完成时，函数检查  `_to` 是否是合约，如果是，调用 `_to`的 `onERC721Received` 并且检查返回值是否是 `0x150b7a02` (即：`bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`)  如果不是抛出异常。
    // @param _from ：当前的所有者
    // @param _to ：新的所有者
    // @param _tokenId ：要转移的token id.
    // @param data : 附加额外的参数（没有指定格式），传递给接收者。
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;

    // @notice 将NFT的所有权从一个地址转移到另一个地址，功能同上，不带data参数。
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

    // @notice 转移所有权 -- 调用者负责确认`_to`是否有能力接收NFTs，否则可能永久丢失。
    // @dev 如果`msg.sender` 不是当前的所有者（或授权者、操作员）抛出异常
    // 如果 `_from` 不是所有者、`_to` 是零地址、`_tokenId` 不是有效id 均抛出异常。
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

    // @notice 更改或确认NFT的授权地址
    // @dev 零地址表示没有授权的地址。
    //  如果`msg.sender` 不是当前的所有者或操作员
    // @param _approved 新授权的控制者
    // @param _tokenId ： token id
    function approve(address _approved, uint256 _tokenId) external payable;

    // @notice 启用或禁用第三方（操作员）管理 `msg.sender` 所有资产
    // @dev 触发 ApprovalForAll 事件，合约必须允许每个所有者可以有多个操作员。
    // @param _operator 要添加到授权操作员列表中的地址
    // @param _approved True 表示授权, false 表示撤销
    function setApprovalForAll(address _operator, bool _approved) external;

    // @notice 获取单个NFT的授权地址
    // @dev 如果 `_tokenId` 无效，抛出异常。
    // @param _tokenId ：  token id
    // @return 返回授权地址， 零地址表示没有。
    function getApproved(uint256 _tokenId) external view returns (address);

    // @notice 查询一个地址是否是另一个地址的授权操作员
    // @param _owner 所有者
    // @param _operator 代表所有者的授权操作员
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

interface ERC165 {
    // @notice 是否合约实现了接口
    // @param interfaceID  ERC-165定义的接口id
    // @dev 函数要少于  30,000 gas.
    // @return 合约实现了 `interfaceID`（不为  0xffffffff）返回`true` ， 否则false.
    function supportsInterface(bytes4 interfaceID) external view returns (bool);
}
// @dev 按 ERC-165 标准，接口id为 0x150b7a02.

interface ERC721TokenReceiver {
    // @notice 处理接收NFT
    // @dev ERC721智能合约在`transfer`完成后，在接收这地址上调用这个函数。
    // 函数可以通过revert 拒绝接收。返回非`0x150b7a02` 也同样是拒绝接收。
    // 注意: 调用这个函数的 msg.sender是ERC721的合约地址
    // @param _operator ：调用 `safeTransferFrom` 函数的地址。
    // @param _from ：之前的NFT拥有者
    // @param _tokenId ： NFT token id
    // @param _data ： 附加信息
    // @return 正确处理时返回 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns(bytes4);
}