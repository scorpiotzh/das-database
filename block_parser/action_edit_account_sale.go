package block_parser

import (
	"das_database/dao"
	"das_database/timer"
	"fmt"
	"github.com/DeAccountSystems/das-lib/common"
	"github.com/DeAccountSystems/das-lib/core"
	"github.com/DeAccountSystems/das-lib/witness"
)

func (b *BlockParser) ActionEditAccountSale(req FuncTransactionHandleReq) (resp FuncTransactionHandleResp) {
	if isCV, err := isCurrentVersionTx(req.Tx, common.DasContractNameAccountSaleCellType); err != nil {
		resp.Err = fmt.Errorf("isCurrentVersionTx err: %s", err.Error())
		return
	} else if !isCV {
		log.Warn("not current version edit account sale tx")
		return
	}

	log.Info("ActionEditAccountSale:", req.TxHash)

	builder, err := witness.AccountSaleCellDataBuilderFromTx(req.Tx, common.DataTypeNew)
	if err != nil {
		resp.Err = fmt.Errorf("AccountSaleCellDataBuilderFromTx err: %s", err.Error())
		return
	}

	tokenInfo := timer.GetTokenPriceInfo(timer.TokenIdCkb)
	oID, _, oCT, _, oA, _ := core.FormatDasLockToHexAddress(req.Tx.Outputs[0].Lock.Args)
	priceUsd := tokenInfo.GetPriceUsd(builder.Price)
	tradeInfo := dao.TableTradeInfo{
		BlockNumber:      req.BlockNumber,
		Outpoint:         common.OutPoint2String(req.TxHash, uint(builder.Index)),
		Account:          builder.Account,
		OwnerAlgorithmId: oID,
		OwnerChainType:   oCT,
		OwnerAddress:     oA,
		Description:      builder.Description,
		StartedAt:        builder.StartedAt,
		BlockTimestamp:   req.BlockTimestamp,
		PriceCkb:         builder.Price,
		PriceUsd:         priceUsd,
		ProfitRate:       builder.BuyerInviterProfitRate,
		Status:           dao.AccountStatusOnSale,
	}
	transactionInfo := dao.TableTransactionInfo{
		BlockNumber:    req.BlockNumber,
		Account:        tradeInfo.Account,
		Action:         common.DasActionEditAccountSale,
		ServiceType:    dao.ServiceTypeTransaction,
		ChainType:      tradeInfo.OwnerChainType,
		Address:        tradeInfo.OwnerAddress,
		Capacity:       0,
		Outpoint:       common.OutPoint2String(req.TxHash, uint(builder.Index)),
		BlockTimestamp: req.BlockTimestamp,
	}

	log.Info("ActionEditAccountSale:", transactionInfo.Account)

	if err := b.dbDao.EditAccountSale(tradeInfo, transactionInfo); err != nil {
		resp.Err = fmt.Errorf("EditAccountSale err: %s", err.Error())
		return
	}

	return
}
