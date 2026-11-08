// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title EconoChain - Econometric Model Registry & Prediction Audit
 * @notice Solves hindsight bias by registering time-stamped econometric forecasts, 
 * regression parameters, and dataset hashes on the Sepolia testnet prior to market outcomes.
 */
contract SmartContract {

    struct Forecast {
        uint256 id;
        string modelName;        // e.g., "ARIMA(1,1,1) Inflation Model" or "Multivariate Regression"
        string targetVariable;   // e.g., "KSE-100 Index Return Q4" or "CPI Inflation Rate"
        int256 predictedValue;   // Scaled value (e.g., 550 for 5.50%)
        int256 actualValue;      // Recorded after real-world outcome is revealed
        string datasetHash;      // IPFS hash or URI of EViews/SPSS data output
        address analyst;         // Address of the analyst who published the forecast
        uint256 timestamp;       // Block timestamp of creation
        bool isResolved;         // Resolution status flag
    }

    uint256 private forecastCounter;
    mapping(uint256 => Forecast) public forecasts;
    mapping(address => uint256[]) private analystForecasts;

    // Events
    event ForecastPublished(
        uint256 indexed id,
        string modelName,
        string targetVariable,
        int256 predictedValue,
        address indexed analyst,
        uint256 timestamp
    );

    event OutcomeResolved(
        uint256 indexed id,
        int256 actualValue,
        int256 absoluteError
    );

    // 1. WRITE FUNCTION: Publish a new econometric forecast
    function publishForecast(
        string memory _modelName,
        string memory _targetVariable,
        int256 _predictedValue,
        string memory _datasetHash
    ) external returns (uint256) {
        require(bytes(_modelName).length > 0, "Model name cannot be empty");
        require(bytes(_targetVariable).length > 0, "Target variable cannot be empty");

        forecastCounter++;
        uint256 newId = forecastCounter;

        forecasts[newId] = Forecast({
            id: newId,
            modelName: _modelName,
            targetVariable: _targetVariable,
            predictedValue: _predictedValue,
            actualValue: 0,
            datasetHash: _datasetHash,
            analyst: msg.sender,
            timestamp: block.timestamp,
            isResolved: false
        });

        analystForecasts[msg.sender].push(newId);

        emit ForecastPublished(
            newId,
            _modelName,
            _targetVariable,
            _predictedValue,
            msg.sender,
            block.timestamp
        );

        return newId;
    }

    // 2. WRITE FUNCTION: Resolve actual outcome and record statistical accuracy
    function resolveOutcome(uint256 _id, int256 _actualValue) external {
        Forecast storage forecast = forecasts[_id];
        require(forecast.id != 0, "Forecast does not exist");
        require(msg.sender == forecast.analyst, "Only the original analyst can resolve this forecast");
        require(!forecast.isResolved, "Forecast is already resolved");

        forecast.actualValue = _actualValue;
        forecast.isResolved = true;

        int256 absoluteError = _actualValue >= forecast.predictedValue
            ? _actualValue - forecast.predictedValue
            : forecast.predictedValue - _actualValue;

        emit OutcomeResolved(_id, _actualValue, absoluteError);
    }

    // 3. READ FUNCTION: Query full details of a single forecast by ID
    function getForecastDetails(uint256 _id) external view returns (
        uint256 id,
        string memory modelName,
        string memory targetVariable,
        int256 predictedValue,
        int256 actualValue,
        string memory datasetHash,
        address analyst,
        uint256 timestamp,
        bool isResolved
    ) {
        Forecast memory f = forecasts[_id];
        require(f.id != 0, "Forecast does not exist");
        return (
            f.id,
            f.modelName,
            f.targetVariable,
            f.predictedValue,
            f.actualValue,
            f.datasetHash,
            f.analyst,
            f.timestamp,
            f.isResolved
        );
    }

    // 4. READ FUNCTION: Get total count of registered econometric forecasts
    function getTotalForecasts() external view returns (uint256) {
        return forecastCounter;
    }

    // 5. READ FUNCTION: Get list of forecast IDs registered by a specific analyst address
    function getAnalystForecasts(address _analyst) external view returns (uint256[] memory) {
        return analystForecasts[_analyst];
    }
}