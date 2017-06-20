/*
 * eGov suite of products aim to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) <2015>  eGovernments Foundation
 *
 *     The updated version of eGov suite of products as by eGovernments Foundation
 *     is available at http://www.egovernments.org
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see http://www.gnu.org/licenses/ or
 *     http://www.gnu.org/licenses/gpl.html .
 *
 *     In addition to the terms of the GPL license to be adhered to in using this
 *     program, the following additional terms are to be complied with:
 *
 *         1) All versions of this program, verbatim or modified must carry this
 *            Legal Notice.
 *
 *         2) Any misrepresentation of the origin of the material is prohibited. It
 *            is required that all modified versions of this material be marked in
 *            reasonable ways as different from the original version.
 *
 *         3) This license does not grant any rights to any user of the program
 *            with regards to rights under trademark law for use of the trade names
 *            or trademarks of eGovernments Foundation.
 *
 *   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 */
package org.egov.works.autonumber.impl;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

import org.egov.commons.CFinancialYear;
import org.egov.commons.dao.FinancialYearHibernateDAO;
import org.egov.infra.persistence.utils.ApplicationSequenceNumberGenerator;
import org.egov.model.bills.EgBillregister;
import org.egov.works.autonumber.AdvanceRequisitionNumberGenerator;
import org.egov.works.contractoradvance.entity.ContractorAdvanceRequisition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AdvanceRequisitionNumberGeneratorImpl implements AdvanceRequisitionNumberGenerator {

    private static final String ADVANCEREQUISITION_NUMBER_SEQ_PREFIX = "SEQ_ADVANCEREQUISITION_NUMBER";

    private static final String ADVANCEBILL_NUMBER_SEQ_PREFIX = "SEQ_ADVANCEBILL_NUMBER";

    @Autowired
    private ApplicationSequenceNumberGenerator applicationSequenceNumberGenerator;

    @Autowired
    private FinancialYearHibernateDAO financialYearHibernateDAO;

    @Override
    @Transactional
    public String getNextNumber(final ContractorAdvanceRequisition advanceRequisition) {
        final CFinancialYear financialYear = financialYearHibernateDAO
                .getFinYearByDate(advanceRequisition.getAdvanceRequisitionDate());
        final String finYearRange[] = financialYear.getFinYearRange().split("-");
        final String sequenceName = ADVANCEREQUISITION_NUMBER_SEQ_PREFIX + "_" + finYearRange[0] + "_" + finYearRange[1];
        Serializable sequenceNumber;
        sequenceNumber = applicationSequenceNumberGenerator.getNextSequence(sequenceName);
        return String.format("ARF/%06d/%02d/%s", sequenceNumber,
                getMonthOfTransaction(advanceRequisition.getAdvanceRequisitionDate()), financialYear.getFinYearRange());
    }

    private int getMonthOfTransaction(final Date advanceRequisitionDate) {
        final Calendar cal = Calendar.getInstance();
        cal.setTime(advanceRequisitionDate);
        return cal.get(Calendar.MONTH) + 1;
    }

    @Override
    @Transactional
    public String getAdvanceBillNumber(final EgBillregister egBillregister) {
        final CFinancialYear financialYear = financialYearHibernateDAO
                .getFinYearByDate(egBillregister.getBilldate());
        final String finYearRange[] = financialYear.getFinYearRange().split("-");
        final String sequenceName = ADVANCEBILL_NUMBER_SEQ_PREFIX + "_" + finYearRange[0] + "_" + finYearRange[1];
        Serializable sequenceNumber;
        sequenceNumber = applicationSequenceNumberGenerator.getNextSequence(sequenceName);
        return String.format("ADV/%06d/%02d/%s", sequenceNumber,
                getMonthOfTransaction(egBillregister.getBilldate()), financialYear.getFinYearRange());
    }
}