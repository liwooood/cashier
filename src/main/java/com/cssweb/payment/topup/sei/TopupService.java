package com.cssweb.payment.topup.sei;

import com.cssweb.payment.common.BasicResponse;
import org.springframework.stereotype.Service;

/**
 * Created by chenhf on 2014/6/27.
 */
@Service
public interface TopupService {

    public BasicResponse topup();
}
